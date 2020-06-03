#include "bes3plotstyle.C"
void plot(){
	TString tree("vxyz"),branch("rvxy0");

	TFile* mfile=new TFile("rhopi_ana.root");
	TTree *mytree = (TTree *)mfile->Get(tree);

//      TChain* mytree = new TChain("tree");
//      mytree->Add("chain/*.root");

	Double_t x,y;
	///////////////// 1 /////////////////////
	mytree->SetBranchAddress(branch,&x);
	TH1D* hist=new TH1D("htemp",branch,100,0,1);
	Int_t nev=(Int_t)mytree->GetEntries();
        for (int i=0;i<nev;i++){
                mytree->GetEntry(i);
                hist->Fill(x);
        }
	/*************************/
	NameAxes(hist,branch,"");
//	FormatData(hist);
//	SetPrelimStyle();
//	SetMeetingStyle();
//	SetStyle();
//	WriteBes3();
//	MakeLegend();
	PlotScatter(tree+"-"+branch,hist,0);
	/************************/
	hist->Draw();
	///////////////// 2 /////////////////////
//	mytree->SetBranchAddress("y",&y);
//	TH1D* h2=new TH1D("h2","hist2",40,0,9);
//	mytree->Draw("y>>h2");
}
