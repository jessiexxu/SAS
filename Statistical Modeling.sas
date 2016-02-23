/*Use logistic regression to derive the likelihood of selecting Product A among potential users*/

ods listing close;	
ods csv file="folder location\example.csv";
proc glimmix data=example;	
	class x1 x2 x3 x4 x5 x6;
	model Product_A_selection (event='1') =x1 x2 x3 x4 x5 x6 /dist=binary solution;
	random respid pat_id;
run;

ods csv close;	
ods listing;

/*Simple linear regression*/

   title 'Simple Linear Regression';
   data Class;
      input Name $ Height Weight Age @@;
      datalines;
   Alfred  69.0 112.5 14  Alice  56.5  84.0 13  Barbara 65.3  98.0 13
   Carol   62.8 102.5 14  Henry  63.5 102.5 14  James   57.3  83.0 12
   Jane    59.8  84.5 12  Janet  62.5 112.5 15  Jeffrey 62.5  84.0 13
   John    59.0  99.5 12  Joyce  51.3  50.5 11  Judy    64.3  90.0 14
   Louise  56.3  77.0 12  Mary   66.5 112.0 15  Philip  72.0 150.0 16
   Robert  64.8 128.0 12  Ronald 67.0 133.0 15  Thomas  57.5  85.0 11
   William 66.5 112.0 15
   ;
   
   ods graphics on;
   
   proc reg;
      model Weight = Height;
   run;
   
   ods graphics off;
