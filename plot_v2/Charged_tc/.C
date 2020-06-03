#include "../bes3plotstyle.C"

void (){
        Double_t x1,x2;

	Int_t bin1(),
	      bin2();
	Double_t x1_min(),x1_max(),
		 x2_min(),x2_max();
        TString tree1(""),branch1("");
        TString tree2(""),branch2("");
	TString namex(""),namey("");

        TFile* mfile1=new TFile("../Rhopi_signal.root");
        TFile* mfile2=new TFile("../Rhopi_inclusive.root");

        TTree *mytree1 = (TTree *)mfile1->Get(tree1);
        TTree *mytree2 = (TTree *)mfile2->Get(tree2);

        mytree1->SetBranchAddress(branch1,&x1);
        mytree2->SetBranchAddress(branch2,&x2);

        TH1D* hist1=new TH1D("htemp1",branch1,bin1,x1_min,x1_max);
        TH1D* hist2=new TH1D("htemp2",branch2,bin2,x2_min,x2_max);

        Int_t nev1=(Int_t)mytree1->GetEntries();
        Int_t nev2=(Int_t)mytree2->GetEntries();

        for (int i=0;i<nev1;i++){
                mytree1->GetEntry(i);
                hist1->Fill(x1);
        }

        for (int i=0;i<nev2;i++){
                mytree2->GetEntry(i);
                hist2->Fill(x2);
        }

        TCanvas* c1 = new TCanvas("c1","c1", 1 );
        NameAxes(hist1,namex,namey);
        hist1->Draw();
	hist2->Draw(SAME);
	c1->Print(tree1+"-"+branch1+".png");

}
