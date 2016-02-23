/*Use logistic regression to derive the likelihood of selecting Product A among potential users*/

proc glimmix data=example;	
	class x1 x2 x3 x4 x5 x6;
	model Product_A_selection (event='1') =x1 x2 x3 x4 x5 x6 /dist=binary solution ;
run;

/*Add randome effects to the logistic regression*/
