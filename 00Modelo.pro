#Section Prolog

#Region Get Username
    sClient = TM1User();
	sUserDesc = CellGetS( '}ElementAttributes_}Clients', sClient, '}TM1_DefaultDisplayValue' );
    nIndexStringUser = SCAN( '/', sUserDesc );
    sUser = SUBST( sUserDesc, nIndexStringUser + 1, LONG( sUserDesc ) - nIndexStringUser );
#EndRegion Get Username

#Region General Statements
	sCubeSrc = 'Source_Cube';
	sDimSrc = 'Source_Dim';
	sCubeTgt = 'Target_Cube';
	sDimTgt = 'Target_Dim';
	cProcess = GetProcessName();
	sView = cProcess|'_View';
	sSubset = cProcess|'_Subset';
#EndRegion General Statements

#Region Views
	#Region Sorce view
		#Region View variables
			nDestroySubset = 1;
			nDestroyView = 1;
			nSuppressZeroes = 1;
		#EndRegion View variables

		#Region Subset MDX
			sDimMeasure = '0X_Dimension';
			sDim = sDimMeasure;
			IF( SubsetExists( sDim, sSubset ) = 1 );
				SubsetDestroy( sDim, sSubset );
			ENDIF;
			sMDX = '{TM1FILTERBYLEVEL(TM1SUBSETALL(['|sDim|'].['|sDim|']), 0)}';
			SubsetCreate( sDim, sSubset, nDestroySubset );
			SubsetMDXSet( sDim, sSubset , sMDX );
			SubsetMDXSet( sDim, sSubset , '' );
		#EndRegion Subset MDX

		#Region Subset Element
			sDimMeasure = '0X_Dimension';
			sDim = sDimMeasure;
			sElement = '';
			IF( SubsetExists( sDim, sSubset ) = 1 );
				SubsetDestroy( sDim, sSubset );
			ENDIF;
			SubsetCreate( sDim, sSubset, nDestroySubset );
			SubsetElementInsert( sDim, sSubset, sElement, 1 );
		#EndRegion Subset Element

		#Region View create
			IF( ViewExists( sCubeSrc, sView ) = 0 );
				ViewDestroy( sCubeSrc, sView );
			ENDIF;
			ViewCreate( sCubeSrc, sView, nDestroyView );
			ViewSubsetAssign( sCubeSrc, sView, sDimMeasure, sSubset );
			ViewSuppressZeroesSet( sCubeSrc, sView, nSuppressZeroes );
			DatasourceCubeview = sView;
		#EndRegion View create
	#EndRegion Sorce view

	#Region ZeroOut view
		#Region View variables
			nDestroySubsetZeroOut = 1;
			nDestroyViewZeroOut = 1;
			nSuppressZeroes = 1;
			sViewZeroOut = sView|'_ZeroOut'
			sSubsetZeroOut = sSubset|'_ZeroOut'
		#EndRegion View variables

		#Region Subset MDX
			sDimMeasure = '0X_Dimension';
			sDim = sDimMeasure;
			sMDX = '{TM1FILTERBYLEVEL(TM1SUBSETALL(['|sDim|'].['|sDim|']), 0)}';
			IF( SubsetExists( sDim, sSubsetZeroOut ) = 1 );
				SubsetDestroy( sDim, sSubsetZeroOut );
			ENDIF;
			SubsetCreate( sDim, sSubsetZeroOut, nDestroySubsetZeroOut );
			SubsetMDXSet( sDim, sSubsetZeroOut , sMDX );
			SubsetMDXSet( sDim, sSubsetZeroOut , '' );
		#EndRegion Subset MDX

		#Region Subset Element
			sDimMeasure = '0X_Dimension';
			sDim = sDimMeasure;
			sElement = '';
			IF( SubsetExists( sDim, sSubsetZeroOut ) = 1 );
				SubsetDestroy( sDim, sSubsetZeroOut );
			ENDIF;
			SubsetCreate( sDim, sSubsetZeroOut, nDestroySubsetZeroOut );
			SubsetElementInsert( sDim, sSubsetZeroOut, sElement, 1 );
		#EndRegion Subset Element

		#Region View create
			IF( ViewExists( sCubeTgt, sViewZeroOut ) = 0 );
				ViewDestroy( sCubeTgt, sViewZeroOut );
			ENDIF;
			ViewCreate( sCubeTgt, sViewZeroOut, nDestroyViewZeroOut );
			ViewSubsetAssign( sCubeTgt, sViewZeroOut, sDimMeasure, sSubsetZeroOut );
			ViewSuppressZeroesSet( sCubeTgt, sViewZeroOut, nSuppressZeroes );
			ViewZeroOut( sCubeTgt, sViewZeroOut );
		#EndRegion View create
	#EndRegion ZeroOut view
#EndRegion Views


#Section Metadata

#Section Data

#Section Epilog
