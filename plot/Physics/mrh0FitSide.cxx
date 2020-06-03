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

#include "../bes3plotstyle.C"
using namespace std;
using namespace RooFit;
void mrh0FitSide(){
	gROOT->SetStyle("Plain");
	gSystem->Load("libRooFit");

        Double_t y,yy;
        Int_t bin1(100);

//	Double_t ee(1.35);
	Double_t ee(1);

	Double_t x1_min(0.62),x1_max(0.92);

        TString tree1("fit5c"),branch1("mrh0");
        TString namex("m(#rho^{0}) / GeV/c^{2}"),namey("Entries / 0.013GeV/c^{2}"),namet("Invariant Mass of #rho^{0} Distribution");

        TFile* mfile1=new TFile("../Rhopi_inclusive.root");
	TFile* mfile2=new TFile("../Rhopi_signal.root");

        TTree *mytree1 = (TTree *)mfile1->Get(tree1);
        TTree *mytree2 = (TTree *)mfile2->Get(tree1);

        mytree1->SetBranchAddress(branch1,&y);
        mytree2->SetBranchAddress(branch1,&yy);

        TH1D* hist1=new TH1D("htemp",branch1,bin1,x1_min,x1_max);
        TH1D* hist2=new TH1D("htemp2",branch1,bin1,x1_min,x1_max);
        
	Int_t nev1=(Int_t)mytree1->GetEntries();
	Int_t nev2=(Int_t)mytree2->GetEntries();
        
	for (int i=0;i<nev1/ee;i++){
                mytree1->GetEntry(i);
                hist1->Fill(y);
        }

        for (int i=0;i<nev2;i++){
                mytree2->GetEntry(i);
                hist2->Fill(yy);
        }

	TCanvas* c = new TCanvas("bes3fit","BESIII Fit", 1200,800);
//	775.26  147.8
	RooRealVar x("x",namex,x1_min,x1_max);
	RooRealVar mean("mean","mean",0.77,0.5,0.9);
	RooRealVar sigma("sigma","sigma",0.142,0.,0.150);
	RooRealVar sigmap("sigmap","sigmap",0.001,0.,0.018);
	RooVoigtian sig("sig","signal p.d.f.",x,mean,sigma,sigmap);
/*
        RooRealVar c0("c0","coefficient #0", 1.0,-1,1);
        RooRealVar c1("c1","coefficient #1", 0.01,-1,1);
        RooRealVar c2("c2","coefficient #2", -0.01,-1,1);
        RooChebychev bkg("bkg","background p.d.f.",x,RooArgList(c0,c1,c2));
	
        RooRealVar x("x",namex,x1_min,x1_max);
        RooRealVar mean("mean","mean",0.774,0.75,0.8);
        RooRealVar sigma("sigma","sigma",0.1478,0.,0.5);
        RooRealVar sigmap("sigmap","sigmap",0.1,0.,0.5);
        RooGExpModel sig("sig","signal p.d.f.",x,mean,sigma,sigma);
*/
	RooPolynomial bkg("bkg","flatx",x);

	RooRealVar nsig("nsig","signal fraction",12500/ee,0.,50000/ee);
	RooRealVar nbkg("nbkg","background fraction",700/ee,0.,50000/ee);
	RooAddPdf model("model","model",RooArgList(sig,bkg),RooArgList(nsig,nbkg));

	RooPlot* frame = x.frame(Title(namet));
	RooDataHist data("data","dataset with x",x,hist1);
	model.fitTo(data,Extended());
	data.plotOn(frame, MarkerStyle(8), MarkerSize(0.8));
	model.plotOn(frame);
	model.plotOn(frame, Components(bkg),LineStyle(kDashed));

        frame->GetXaxis()->CenterTitle( kTRUE );
        frame->GetXaxis()->SetLabelFont( 42 );
        frame->SetXTitle( namex );
        frame->SetYTitle( namey );
        frame->Draw();
	FormatMC1(hist2);
	hist2->Draw("SAME");
	hist1->SetLineColor(kBlue);

//	MakeLegend(0,"",hist2,"Signal MC",hist1,"Inclusive MC",0.7,0.75,0.88,0.85);
        TLegend *legend=new TLegend(0.69,0.73,0.88,0.87);
        legend->SetTextFont(42);
        legend->SetTextSize(0.03);
        legend->SetFillColor(0);
        legend->SetFillStyle(0);
        legend->AddEntry("h_data","Inclusive MC","lpe");
        legend->AddEntry("htemp2","signal MC","l");
        legend->AddEntry("model_Norm[x]","Fiting sig","l");
        legend->AddEntry("model_Norm[x]_Comp[bkg]","Fiting bkg","l");
        legend->Draw("SAME");

	Double_t meanVal = mean.getVal();
	Double_t meanErr = mean.getError();
	Double_t widVal  = sigma.getVal();
        Double_t widErr  = sigma.getError();
        Double_t nsigVal  = nsig.getVal();
        Double_t nsigErr  = nsig.getError();
        Double_t nbkgVal  = nbkg.getVal();
        Double_t nbkgErr  = nbkg.getError();

//        TPaveText *pave = new TPaveText(0.634,165.7,0.73,203.);
	TPaveText *pave = new TPaveText(0.635,205,0.718,265.8);
        pave->SetTextFont(42);
        pave->SetTextSize(0.035);
        pave->SetShadowColor(0);
        pave->SetFillColor(0);
        pave->SetFillStyle(0);
        TString Text;

        stringstream oss1;
        oss1<<"m: "<<setprecision(4)<<meanVal<<" #pm "<<setprecision(3)<<meanErr<<endl;
        Text=oss1.str();
        pave->AddText(Text);

        stringstream oss2;
        oss2<<"#Gamma:       "<<setprecision(4)<<widVal<<" #pm "<<setprecision(3)<<widErr<<endl;
        Text=oss2.str();
        pave->AddText(Text);

        stringstream oss3;
        oss3<<"n_{S}:           "<<setprecision(5)<<nsigVal<<" #pm "<<setprecision(3)<<nsigErr<<endl;
        Text=oss3.str();
        pave->AddText(Text);

        stringstream oss4;
        oss4<<"n_{B}:        "<<setprecision(5)<<nbkgVal<<" #pm "<<setprecision(3)<<nbkgErr<<endl;
        Text=oss4.str();
        pave->AddText(Text);
        pave->Draw("SAME");

	cout<<"m:	"<<meanVal<<endl;
	cout<<"mErr:	"<<meanErr<<endl;
        cout<<"W:       "<<widVal<<endl;
        cout<<"WErr:    "<<widErr<<endl;
        cout<<"Ns:       "<<nsigVal<<endl;
        cout<<"NsErr:    "<<nsigErr<<endl;
        cout<<"Nb:       "<<nbkgVal<<endl;
        cout<<"NbErr:    "<<nbkgErr<<endl;


	c->Print("Picture/"+tree1+"-"+branch1+"-SF.png");
	return;
}
