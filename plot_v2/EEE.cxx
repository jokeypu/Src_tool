#include "RooAbsPdf.h"
#include "RooRealVar.h"
#include "RooBreitWigner.h"
#include "RooGaussian.h"
#include "RooFFTConvPdf.h"
#include "RooChebychev.h"
#include "RooDataSet.h"
#include "TFile.h"
#include "TTree.h"
#include "RooFitResult.h"
#include <sstream>
#include <string>

#include "../bes3plotstyle.C"
using namespace std;
using namespace RooFit;
void @EEE@(){
	gROOT->SetStyle("Plain");
	gSystem->Load("libRooFit");

        Double_t y;

        Int_t bin1(@bin1@);
        Double_t x1_min(@x1_min@),x1_max(@x1_max@);

        stringstream oss;
        oss<<(x1_max-x1_min)/bin1;
        TString bb=oss.str();

        TString tree1("@tree1@"),branch1("@branch1@");
        TString namex("@namex@"),namey("@namey@"),namet("@namet@");

        TFile* mfile1=new TFile("../Rhopi_inclusive.root");
        TTree *mytree1 = (TTree *)mfile1->Get(tree1);

//	TChain* mytree1 = new TChain("tree1");
//	mytree1->Add("../Rhopi_inclusive_chain/*.root");

        mytree1->SetBranchAddress(branch1,&y);

        TH1D* hist1=new TH1D("htemp",branch1,bin1,x1_min,x1_max);

        Int_t nev1=(Int_t)mytree1->GetEntries();

        for (int i=0;i<nev1;i++){
                mytree1->GetEntry(i);
		hist1->Fill(y);
        }

	TCanvas* c = new TCanvas("bes3fit","BESIII Fit", 1200,800);

	RooRealVar x("x",namex,x1_min,x1_max);
	RooRealVar mean("mean","mean",0.77,0.6,0.9);
	RooRealVar sigma("sigma","sigma",0.17,0.00,0.2);
	RooRealVar sigmap("sigmap","sigmap",0.01,0.00,0.018);
	RooVoigtian sig("sig","signal p.d.f.",x,mean,sigma,sigmap);
	
	RooRealVar c0("c0","coefficient #0", 1.0,-1.5,1.5);
	RooRealVar c1("c1","coefficient #1", 0.1,-1.5,1.5);
	RooRealVar c2("c2","coefficient #2",-0.1,-1.5,1.5);
	RooChebychev bkg("bkg","background p.d.f.",x,RooArgList(c0,c1,c2));
	
	RooRealVar nsig("nsig","signal fraction",1150,0.,50000.);
	RooRealVar nbkg("nbkg","background fraction",700,0.,50000.);
	RooAddPdf model("model","model",RooArgList(sig,bkg),RooArgList(nsig,nbkg));

	RooPlot* frame = x.frame(Title(namet));
	RooDataHist data("data","dataset with x",x,hist1);
	model.fitTo(data,Extended());
	data.plotOn(frame, MarkerStyle(21), MarkerSize(0.8));
	model.plotOn(frame);
	model.plotOn(frame, Components(bkg),LineStyle(kDashed));

        frame->GetXaxis()->CenterTitle( kTRUE );
        frame->GetXaxis()->SetLabelFont( 42 );
        frame->SetXTitle( namex );
        frame->SetYTitle( namey );
        frame->Draw();
	c->Print("Picture/"+tree1+"-"+branch1+"-F.png");
	return;
}
