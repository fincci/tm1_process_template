#Section Prolog

#Region General Statements
	sCubeSrc = 'Source_Cube';
	sDimSrc = 'Source_Dim';
	sCubeTgt = 'Target_Cube';
	sDimTgt = 'Target_Dim';
	cProcess = GetProcessName();
#EndRegion General Statements

#Region Views
	#Region Sorce view
		#Region View variables
			sView = cProcess|'_View';
			sSubset = cProcess|'_Subset';
			nSuppressZeroes = 1;
		#EndRegion View variables

		#Region First destroy
			IF( ViewExists( sCubeSrc, sView ) = 1 );
				ViewDestroy( sCubeSrc, sView );
			ENDIF;
		#EndRegion First destroy

		#Region Subset MDX
			sDimName = '0X_Dimension';
			sDim = sDimName;
			IF( SubsetExists( sDim, sSubset ) = 1 );
				SubsetDestroy( sDim, sSubset );
			ENDIF;
			sMDX = '{TM1FILTERBYLEVEL(TM1SUBSETALL(['|sDim|'].['|sDim|']), 0)}';
			SubsetCreate( sDim, sSubset );
			SubsetMDXSet( sDim, sSubset , sMDX );
			SubsetMDXSet( sDim, sSubset , '' );
		#EndRegion Subset MDX

		#Region Subset Element
			sDimName = '0X_Dimension';
			sDim = sDimName;
			sElement = '';
			IF( SubsetExists( sDim, sSubset ) = 1 );
				SubsetDestroy( sDim, sSubset );
			ENDIF;
			SubsetCreate( sDim, sSubset );
			SubsetElementInsert( sDim, sSubset, sElement, 1 );
		#EndRegion Subset Element

		#Region Source view apply
			ViewCreate( sCubeSrc, sView );
			ViewSubsetAssign( sCubeSrc, sView, sDimName, sSubset );
			ViewSuppressZeroesSet( sCubeSrc, sView, nSuppressZeroes );
			DatasourceCubeview = sView;
		#EndRegion Source view apply
	#EndRegion Sorce view

	#Region ViewZeroOut
		#Region View variables
			nSuppressZeroes = 1;
			sViewZeroOut = sView|'_ZeroOut'
			sSubsetZeroOut = sSubset|'_ZeroOut'
		#EndRegion View variables

		#Region First destroy
			IF( ViewExists( sCubeTgt, sViewZeroOut ) = 0 );
				ViewDestroy( sCubeTgt, sViewZeroOut );
			ENDIF;
		#EndRegion First destroy

		#Region Subset MDX
			sDimName = '0X_Dimension';
			sDim = sDimName;
			sMDX = '{TM1FILTERBYLEVEL(TM1SUBSETALL(['|sDim|'].['|sDim|']), 0)}';
			IF( SubsetExists( sDim, sSubsetZeroOut ) = 1 );
				SubsetDestroy( sDim, sSubsetZeroOut );
			ENDIF;
			SubsetCreate( sDim, sSubsetZeroOut );
			SubsetMDXSet( sDim, sSubsetZeroOut , sMDX );
			SubsetMDXSet( sDim, sSubsetZeroOut , '' );
		#EndRegion Subset MDX

		#Region Subset Element
			sDimName = '0X_Dimension';
			sDim = sDimName;
			sElement = '';
			IF( SubsetExists( sDim, sSubsetZeroOut ) = 1 );
				SubsetDestroy( sDim, sSubsetZeroOut );
			ENDIF;
			SubsetCreate( sDim, sSubsetZeroOut );
			SubsetElementInsert( sDim, sSubsetZeroOut, sElement, 1 );
		#EndRegion Subset Element

		#Region ViewZeroOut apply
			ViewCreate( sCubeTgt, sViewZeroOut );
			ViewSubsetAssign( sCubeTgt, sViewZeroOut, sDimName, sSubsetZeroOut );
			ViewSuppressZeroesSet( sCubeTgt, sViewZeroOut, nSuppressZeroes );
			ViewZeroOut( sCubeTgt, sViewZeroOut );
		#EndRegion ViewZeroOut apply

		#Region ViewZeroOut destroy
			ViewDestroy( sCubeTgt, sViewZeroOut );
			SubsetDestroy( sDimName, sSubsetZeroOut );
		#EndRegion ViewZeroOut destroy
	#EndRegion ViewZeroOut
#EndRegion Views

#Section Metadata

#Section Data

#Section Epilog

#Region Source view destroy
	ViewDestroy( sCubeSrc, sView );
	SubsetDestroy( sDimName, sSubset );
#EndRegion Source view destroy
