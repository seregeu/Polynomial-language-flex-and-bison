%{

#include <stdio.h>

FILE* yyin;
int yyerror();

extern int yylex();

%}

%union symval{
	int val;
}

%token <val> ELEM
%type <val> LIST


%%

LIST: ELEM
{
	int test = $$;
	$$ = $1;
	int val = $1;
	printf("%d\n", val);
}
| LIST ELEM
{
	int test = $$;
	$$ = $1;
	int val1 = $1;
	int val2 = $2;
	printf("%d\n", val2);
}

%%

int parser_main(int argc, char* argv[])
{
	if (argc > 2)
	{
		printf("Error: too many parameters\n");
		return 1;
	}
	if (argc == 2)
	{
		yyin = fopen(argv[1], "rb");
		if (yyin == NULL)
		{
			printf("Error: file wasn't opened\n");
			exit(1);
		}
		yyparse();
		fclose(yyin);
	}
	else if (argc == 1)
	{
		yyparse();
	}
	return 0;
}

void yyerror(const char* error_string)
{
	printf("error\n");
	return 1;
}