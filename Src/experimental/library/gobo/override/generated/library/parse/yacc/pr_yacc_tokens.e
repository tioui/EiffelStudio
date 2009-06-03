indexing

	description: "Parser token codes"
	generator: "geyacc version 3.9"

class PR_YACC_TOKENS

inherit

	YY_PARSER_TOKENS

feature -- Last values

	last_any_value: ANY
	last_string_value: STRING
	last_integer_value: INTEGER

feature -- Access

	token_name (a_token: INTEGER): STRING is
			-- Name of token `a_token'
		do
			inspect a_token
			when 0 then
				Result := "EOF token"
			when -1 then
				Result := "Error token"
			when T_TOKEN then
				Result := "T_TOKEN"
			when T_LEFT then
				Result := "T_LEFT"
			when T_RIGHT then
				Result := "T_RIGHT"
			when T_NONASSOC then
				Result := "T_NONASSOC"
			when T_EXPECT then
				Result := "T_EXPECT"
			when T_PREC then
				Result := "T_PREC"
			when T_START then
				Result := "T_START"
			when T_TYPE then
				Result := "T_TYPE"
			when T_2PERCENTS then
				Result := "T_2PERCENTS"
			when T_UNKNOWN then
				Result := "T_UNKNOWN"
			when T_EIFFEL then
				Result := "T_EIFFEL"
			when T_IDENTIFIER then
				Result := "T_IDENTIFIER"
			when T_ACTION then
				Result := "T_ACTION"
			when T_USER_CODE then
				Result := "T_USER_CODE"
			when T_CHAR then
				Result := "T_CHAR"
			when T_STR then
				Result := "T_STR"
			when T_BOOLEAN then
				Result := "T_BOOLEAN"
			when T_POINTER then
				Result := "T_POINTER"
			when T_TUPLE then
				Result := "T_TUPLE"
			when T_AS then
				Result := "T_AS"
			when T_INTEGER then
				Result := "T_INTEGER"
			when T_INTEGER_8 then
				Result := "T_INTEGER_8"
			when T_INTEGER_16 then
				Result := "T_INTEGER_16"
			when T_INTEGER_32 then
				Result := "T_INTEGER_32"
			when T_INTEGER_64 then
				Result := "T_INTEGER_64"
			when T_NATURAL then
				Result := "T_NATURAL"
			when T_NATURAL_8 then
				Result := "T_NATURAL_8"
			when T_NATURAL_16 then
				Result := "T_NATURAL_16"
			when T_NATURAL_32 then
				Result := "T_NATURAL_32"
			when T_NATURAL_64 then
				Result := "T_NATURAL_64"
			when T_REAL then
				Result := "T_REAL"
			when T_REAL_32 then
				Result := "T_REAL_32"
			when T_REAL_64 then
				Result := "T_REAL_64"
			when T_DOUBLE then
				Result := "T_DOUBLE"
			when T_CHARACTER then
				Result := "T_CHARACTER"
			when T_CHARACTER_8 then
				Result := "T_CHARACTER_8"
			when T_CHARACTER_32 then
				Result := "T_CHARACTER_32"
			when T_LIKE then
				Result := "T_LIKE"
			when T_CURRENT then
				Result := "T_CURRENT"
			when T_EXPANDED then
				Result := "T_EXPANDED"
			when T_REFERENCE then
				Result := "T_REFERENCE"
			when T_SEPARATE then
				Result := "T_SEPARATE"
			when T_ATTACHED then
				Result := "T_ATTACHED"
			when T_DETACHABLE then
				Result := "T_DETACHABLE"
			when T_NUMBER then
				Result := "T_NUMBER"
			when T_ERROR then
				Result := "T_ERROR"
			else
				Result := yy_character_token_name (a_token)
			end
		end

feature -- Token codes

	T_TOKEN: INTEGER is 258
	T_LEFT: INTEGER is 259
	T_RIGHT: INTEGER is 260
	T_NONASSOC: INTEGER is 261
	T_EXPECT: INTEGER is 262
	T_PREC: INTEGER is 263
	T_START: INTEGER is 264
	T_TYPE: INTEGER is 265
	T_2PERCENTS: INTEGER is 266
	T_UNKNOWN: INTEGER is 267
	T_EIFFEL: INTEGER is 268
	T_IDENTIFIER: INTEGER is 269
	T_ACTION: INTEGER is 270
	T_USER_CODE: INTEGER is 271
	T_CHAR: INTEGER is 272
	T_STR: INTEGER is 273
	T_BOOLEAN: INTEGER is 274
	T_POINTER: INTEGER is 275
	T_TUPLE: INTEGER is 276
	T_AS: INTEGER is 277
	T_INTEGER: INTEGER is 278
	T_INTEGER_8: INTEGER is 279
	T_INTEGER_16: INTEGER is 280
	T_INTEGER_32: INTEGER is 281
	T_INTEGER_64: INTEGER is 282
	T_NATURAL: INTEGER is 283
	T_NATURAL_8: INTEGER is 284
	T_NATURAL_16: INTEGER is 285
	T_NATURAL_32: INTEGER is 286
	T_NATURAL_64: INTEGER is 287
	T_REAL: INTEGER is 288
	T_REAL_32: INTEGER is 289
	T_REAL_64: INTEGER is 290
	T_DOUBLE: INTEGER is 291
	T_CHARACTER: INTEGER is 292
	T_CHARACTER_8: INTEGER is 293
	T_CHARACTER_32: INTEGER is 294
	T_LIKE: INTEGER is 295
	T_CURRENT: INTEGER is 296
	T_EXPANDED: INTEGER is 297
	T_REFERENCE: INTEGER is 298
	T_SEPARATE: INTEGER is 299
	T_ATTACHED: INTEGER is 300
	T_DETACHABLE: INTEGER is 301
	T_NUMBER: INTEGER is 302
	T_ERROR: INTEGER is 303

end
