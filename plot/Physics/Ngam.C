#include <sstream>
#include <string>
#include "../bes3plotstyle.C"

void Ngam(){
        Double_t x1,x2;

	Int_t bin1(20),
	      bin2(20);
	Double_t x1_min(0),x1_max(10),
		 x2_min(0),x2_max(10);
        stringstream oss;
        oss<<(x1_max-x1_min)/bin1;
        TString bb=oss.str();

        TString tree1("BBB"),branch1("nGam");
        TString tree2("BBB"),branch2("nGam");
	TString namex("N_{#gamma}"),namey("Entries ("+bb+")");

        TFile* mfile1=new TFile("../Rhopi_signal.root");
        TFile* mfile2=new TFile("../Rhopi_bkg.root");

        TTree *mytree1 = (TTree *)mfile1->Get(tree1);
        TTree *mytree2 = (TTree *)mfile2->Get(tree2);

        mytree1->SetBranchAddress(branch1,&x1);
        mytree2->SetBranchAddress(branch2,&x2);

        TH1D* hist1=new TH1D("htemp",branch1,bin1,x1_min,x1_max);
        TH1D* hist2=new TH1D("htemp2",branch2,bin2,x2_min,x2_max);

        Int_t nev1=(Int_t)mytree1->GetEntries();
        Int_t nev2=(Int_t)mytree2->GetEntries();

        for (int i=0;i<nev1;i++){
                mytree1->GetEntry(i);
                hist1->Fill(x1);
        }

        for (int i=0;i<nev1;i++){
                mytree2->GetEntry(i);
                hist2->Fill(x2);
        }

        TCanvas* c1 = new TCanvas("bes3plots","BESIII Plots", 1200,800);
	SetStyle();
        gStyle->SetOptTitle(0);
        gStyle->SetStatX(0.36);
        gStyle->SetStatY(0.88);
        FormatMC1(hist1);
        FormatMC2(hist2);
        NameAxes(hist1,namex,namey);
        FormatAxis(hist1->GetXaxis());
        FormatAxis(hist1->GetYaxis());
        hist1->Draw();
	hist2->Draw("SAME");
	MakeLegend(0,"",hist1,"Signal MC",hist2,"Background MC",0.7,0.75,0.88,0.85);
	c1->Print("Picture/"+tree1+"-"+branch1+".png");

}
