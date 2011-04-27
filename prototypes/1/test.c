#include <stdio.h>
#include <alloca.h>
#include <malloc.h>

typedef struct Method* Method;
struct Method {
    unsigned long locals;
    void * code[];
};

void ** label;

void mth(Method method, void* arg[])
{
    if (arg==NULL)
    {
	void * l[] = {
	    &&print,
	    &&call_method,
	    &&move_local,
	    &&load_arg,
	    &&return_local,
	    &&return_arg,
	    &&return_self
	};
	label = l;
	return;
    }

    unsigned long target;
    unsigned long origin;

    void ** locals = alloca(method->locals * sizeof(void*));

    void ** pc = method->code;
    goto **pc;

print:
    printf("bla %p\n",locals[0]);
    goto **(pc += 1);

call_method:
    target = (unsigned long)pc[0];
    pc += 2;
    mth( (Method)arg[0], &locals[target] );
    goto **pc;

move_local:
    target = (unsigned long)pc[0];
    origin = (unsigned long)pc[1];
    locals[target] = locals[origin];
    pc += 3;
    goto **pc;
    
load_arg:
    target = (unsigned long)pc[0];
    origin = (unsigned long)pc[1];
    locals[target] = arg[origin];
    pc += 3;
    goto **pc;

return_local:
    origin = (unsigned long)pc[0];
    arg[0] = locals[origin];
    return;

return_arg:
    origin = (unsigned long)pc[0];
    arg[0] = arg[origin];
    return;

return_self:
    return;
}

int main()
{
    mth(NULL, NULL);
    
    Method m = malloc( sizeof(struct Method) + 11*sizeof(void*) );
    m->locals  = 2;
    m->code[0] = label[0];
    m->code[1] = label[3];
    m->code[2] = 0;
    m->code[3] = 1;
    m->code[4] = label[3];
    m->code[5] = 1;
    m->code[6] = 2;
    m->code[7] = label[0];
    m->code[8] = label[1];
    m->code[9] = 1;
    m->code[10] = label[6];
    
    Method m2 = malloc( sizeof(struct Method) + 10*sizeof(void*) );
    m2->locals  = 1;
    m2->code[0] = label[3];
    m2->code[1] = 0;
    m2->code[2] = 0;
    m2->code[3] = label[0];
    m2->code[4] = label[1];

    void ** arg = alloca( 3 * sizeof(void*) );
    arg[0] = m2;
    arg[1] = (void**)2;
    arg[2] = (void**)3;

    mth(m, arg);

}
