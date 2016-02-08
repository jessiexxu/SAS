/*
In some data files, there are records overlapped with each other which can affect analysis results.
For example, when we look at the sales data for medications, we usually observe that the prescription
filling intervals are overlapped, meaning that the refilled medications can be shipped out before
patients run out of their current prescription. If we use this type of data to analyze patients' compliance
with the medication, we'll underestimate the number of "compliant" days by ignoring these overlapped
filling intervals.

I created the following SAS program to identify the overlaps in the data with records for thousands of patients
and shift the overlapped records using the do loop with 2 iterations. Only 2 iterations in the do loop would
be sufficient even for millions of sales records, because:
1). SAS processes the code by each row in the data. For the do loop, SAS runs it twice for the first row, then
runs twice for the second row, etc.
2). In the do loop, I reset the values of start1 and start2 so SAS will take the updated start1 and start2 to 
run for the next row
*/

data example;
  set example;
  id1=Pat_id;
  id2=lag(id1);
  start1=ShipDate;
  start2=lag(start1);
  DaysSupply1=DaysSupply;
  DaysSupply2=lag(DaysSupply1);
  newstart=ShipDate;

    do i=1 to 2;
      if id2=id1 and start1<start2+DaysSupply2 
      then newstart=start2+DaysSupply2;
      start1=newstart;
      start2=lag(start1);
    end;

  newstart2=lag(newstart);
  newend=newstart+DaysSupply;
  NonComplDays=(newstart2+DaysSupply2)-newstart; /*Calculate NonCompDays between fills*/
  if (id2 ne id1) then NonComplDays=.; /*Set NonCompDays to missing if it's not for the same patient*/

  format newstart yymmdd10.
         newend yymmdd10.;
  drop start1 start2 DaysSupply1 id1 id2 DaysSupply2 i newstart2;
run;
