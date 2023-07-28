#Section Prolog
#****Begin: Generated Statements***
#****End: Generated Statements****

#Region Get Username
    sClient = TM1User();
	sUserDesc = CellGetS( '}ElementAttributes_}Clients', sClient, '}TM1_DefaultDisplayValue' );
    nIndexStringUser = SCAN( '/', sUserDesc );
    sUser = SUBST( sUserDesc, nIndexStringUser + 1, LONG( sUserDesc ) - nIndexStringUser );
#EndRegion

#Region General Statements
	sCubeSrc = 'Sorce_Cube';
	sCubeTgt = 'Target_Cube';
	sCubeAux = 'SYS_Cadastro_Email';
	cProcess = GetProcessName();
	sView = cProcess|'_View';
	sSubset = cProcess|'_Subset';
	# sView = cProcess|'_'|sUser|'_View';
	# sSubset = cProcess|'_'|sUser|'_Subset';
#EndRegion

#Region View variables
	nDestroySubset = 1;
	nDestroyView = 1;
	nSkipCalcs = 1;
	nSuppressZeroes = 1;
#EndRegion

#Region Subset MDX
	sDimMeasure = '0X_Dimension';
	sMDX = '{TM1FILTERBYLEVEL(TM1SUBSETALL([0X_Dimension].[0X_Dimension]), 0)}';
	SubsetCreate( sDimMeasure, sSubset, nDestroySubset );
	SubsetMDXSet( sDimMeasure, sSubset , sMDX );
	SubsetMDXSet( sDimMeasure, sSubset , '' );
#EndRegion

#Region Subset Element
	sDimMeasure = '0X_Dimension';
	sElement = '';
	SubsetCreate( sDimMeasure, sSubset, nDestroySubset );
	SubsetElementInsert( sDimMeasure, sSubset, sElement, 1 );
#EndRegion

#Region View create
	ViewCreate( sCubeSrc, sView, nDestroyView );
	ViewSubsetAssign( sCubeSrc, sView, sDimMeasure, sSubset );
	ViewExtractSkipCalcsSet( sCubeSrc, sView, nSkipCalcs );
	ViewExtractSkipZeroesSet( sCubeSrc, sView, nSuppressZeroes );
	DatasourceCubeview = sView;
#EndRegion

#Section Metadata
#****Begin: Generated Statements***
#****End: Generated Statements****

#Section Data
#****Begin: Generated Statements***
#****End: Generated Statements****

#Section Epilog
#****Begin: Generated Statements***
#****End: Generated Statements****
