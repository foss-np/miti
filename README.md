#date-converter

Converts dates from B.S. to A.D.

A class to convert Bikram Samwat (B.S.) to A.D. and vice versa.
    
#### HOW-TO USE

	converter = NepaliDateConverter()
    print converter.ad2bs((1995,9,12))
    print converter.bs2ad((2052,05,27))
    
    Range:
    1944 A.D. to 2033 A.D.
    2000 B.S. to 2089 B.S.
    
    bs : a dictionary that contains the number of days in each month of the B.S. year
    bs_equiv, ad_equiv  : The B.S. and A.D. equivalent dates for counting and calculation
    
    '''
