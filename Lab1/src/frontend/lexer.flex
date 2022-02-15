/* You do not need to change anything up here. */
package lexer;

import frontend.Token;
import static frontend.Token.Type.*;

%%

%public
%final
%class Lexer
%function nextToken
%type Token
%unicode
%line
%column

%{
	/* These two methods are for the convenience of rules to create toke objects.
	* If you do not want to use them, delete them
	* otherwise add the code in 
	*/
	
	private Token token(Token.Type type) {
		return token(type, yytext());
	}
	
	/* Use this method for rules where you need to process yytext() to get the lexeme of the token.
	 *
	 * Useful for string literals; e.g., the quotes around the literal are part of yytext(),
	 *       but they should not be part of the lexeme. 
	*/
	private Token token(Token.Type type, String text) {
		return new Token(type, yyline, yycolumn, text);
	}
%}

/* This definition may come in handy. If you wish, you can add more definitions here. */

WhiteSpace = [ ] | \t | \f | \n | \r
String = \" [^\"\n]* \"


%%
/* put in your rules here.    */

/*keywords*/
"boolean" { return token(BOOLEAN); }
"break" { return token(BREAK); }
"false" { return token(FALSE); }
"if" { return token(IF); }
"import" { return token(IMPORT); }
"module" { return token(MODULE); }
"public" { return token(PUBLIC); }
"return" { return token(RETURN); }
"true" { return token(TRUE); }
"type" { return token(TYPE); }
"void" { return token(VOID); }
"while" { return token(WHILE); }
"int" { return token(INT); }
"else" { return token(ELSE); }


/*punctuation*/
"(" { return token(LPAREN); }
")" { return token(RPAREN); }
"[" { return token(LBRACKET); }
"]" { return token(RBRACKET); }
"{" { return token(LCURLY); }
"}" { return token(RCURLY); }
";" { return token(SEMICOLON); }
"," { return token(COMMA); }


/*operators*/
"+" { return token(PLUS); }
"==" { return token(EQEQ); }
"=" { return token(EQL); }
"/" { return token(DIV); }
">=" { return token(GEQ); }
">" { return token(GT); }
"<=" { return token(LEQ); }
"<" { return token(LT); }
"-" { return token(MINUS); }
"!=" { return token(NEQ); }
"*" { return token(TIMES); }

/* identifier*/
[a-zA-Z][a-zA-Z0-9_]*	{ return token(ID); }
[0-9]+		{ return token(INT_LITERAL); }
{String} { return token(STRING_LITERAL, yytext().substring(1, yytext().length() - 1)); }


{WhiteSpace} {}


/* You don't need to change anything below this line. */
.							{ throw new Error("unexpected character '" + yytext() + "'"); }
<<EOF>>						{ return token(EOF); }
