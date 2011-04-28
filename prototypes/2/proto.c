#include <stdio.h>
#include <alloca.h>
#include <malloc.h>

typedef struct Method* Method;
struct Method {
    unsigned long locals;
    void * code[];
};

//exported goto labels. those are are the opcodes
void * print;
void * call_method;
void * move_local;
void * load_arg;
void * return_;

int mth(Method method, void** arg)
{
    //only used on the first call. export all goto-labels to be used outside mth.
    if (arg==NULL)
    {
    	print = &&print;
    	call_method = &&call_method;
    	move_local = &&move_local;
    	load_arg = &&load_arg;
    	return_ = &&return_;
	    return;
    }

    printf("entering method %p\n",method);
    
    //registers
    unsigned long target;
    unsigned long offset;
    unsigned long origin;

    //allocate stack-frame.
    register void ** stack_pointer __asm("rsp");
    alloca(method->locals * sizeof(void*));

    //set program counter to first instruction
    void ** pc = method->code;
    goto **pc;

print:
    origin = (unsigned long)pc[1];
    printf("local %d is: %p\n", origin, stack_pointer[origin]);
    goto **(pc += 2);

call_method:
    origin = (unsigned long)pc[1];
    offset = (unsigned long)pc[2];
    //all locals after offset are arguments to the callee.
    mth( (Method)stack_pointer[origin], &stack_pointer[offset] );
    origin = offset = NULL;
    pc += 3;
    goto **pc;

move_local:
    target = (unsigned long)pc[1];
    origin = (unsigned long)pc[2];
    stack_pointer[target] = stack_pointer[origin];
    pc += 3;
    goto **pc;
    
load_arg:
    target = (unsigned long)pc[1];
    origin = (unsigned long)pc[2];
    stack_pointer[target] = arg[origin];
    pc += 3;
    goto **pc;

return_:
    printf("return from %p\n",method);
    return 0;
}

int main()
{
    mth(NULL, NULL);
    
    Method m = malloc( sizeof(struct Method) + 20*sizeof(void*) );
    m->locals  = 2;

    int i = 0;

    //load first argument as second local
    m->code[i++] = load_arg;
    m->code[i++] = (unsigned long)1;
    m->code[i++] = (unsigned long)0;
    
    //load second argument as first local
    m->code[i++] = load_arg;
    m->code[i++] = (unsigned long)0;
    m->code[i++] = (unsigned long)1;
    
    //print the locals
    m->code[i++] = print;
    m->code[i++] = (unsigned long)0;
    m->code[i++] = print;
    m->code[i++] = (unsigned long)1;

    //call function2
    m->code[i++] = call_method;
    m->code[i++] = (unsigned long)0;
    m->code[i++] = (unsigned long)1;

    m->code[i++] = return_;
    
    Method m2 = malloc( sizeof(struct Method) + 10*sizeof(void*) );
    m2->locals  = 1;

    i=0;

    //load argument
    m2->code[i++] = load_arg;
    m2->code[i++] = (unsigned long)0;
    m2->code[i++] = (unsigned long)0;

    //print
    m2->code[i++] = print;
    m2->code[i++] = (unsigned long)0;

    m2->code[i++] = return_;
    


    //run those functions:
    void ** arg = alloca( 2 * sizeof(void*) );
    arg[0] = (void**)2;
    arg[1] = m2;

    return mth(m, arg);

}
