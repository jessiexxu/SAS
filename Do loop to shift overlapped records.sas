/*
In some data files, there are records overlapped with each other which can affect analysis results.
For example, when we look at the sales data for medications, we usually observe that the prescription
filling intervals are overlapped, meaning that the refilled medications can be shipped out before
patients run out of their current prescription. If we use this type of data to analyze patients' compliance
with the medication, we'll underestimate the number of "compliant" days by ignoring these overlapped
filling intervals.

I created the following SAS program to identify the overlaps in the data and shift the overlapped records
using the do loop
*/

data test;
