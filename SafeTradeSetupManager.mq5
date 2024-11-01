//+------------------------------------------------------------------+
//|                        Kovacs Trading - Safe Trade Setup Manager |
//|                                                   Kovacs Trading |
//|                                       https://kovacstrading.com/ |
//+------------------------------------------------------------------+

#property description "Calculate your trade size instantly and use risk management like a pro with our free, user-friendly safe trade setup manager!"
#property description "Step 1: Create a new long or short trade.";
#property description "Step 2: Input your preferred account % or flat balance to risk per trade.";
#property description "Step 3: Drag the horizontal lines on your desired entry (BLACK), take-profit (GREEN), stop-loss (RED) price.";
#property description "Step 4: Execute your trade, it will have the correct position size based on your risk per trade settings.";
#property copyright "Kovacs Trading"
#property link      "https://kovacstrading.com/"
#property version   "1.00"

//+------------------------------------------------------------------+
//| Library                                                          |
//+------------------------------------------------------------------+

#include <Controls\Dialog.mqh>
#include <Controls\Button.mqh>
#include <Controls\Label.mqh>
#include <Controls\Edit.mqh>

//+------------------------------------------------------------------+
//| Variables                                                        |
//+------------------------------------------------------------------+

int appWidth = 320;
int appHeight = 290;
int buttonLength = 125;

double RiskPercentage = 1;
double RiskMoney = AccountInfoDouble(ACCOUNT_BALANCE) / 100 * RiskPercentage;

string fontFamily = "Calibri";
string boldFontFamily = "Calibri Bold";

//+------------------------------------------------------------------+

CAppDialog AppWindow;

CLabel NewTradeLabel;

CLabel RiskPerTradeSettingsLabel;

CLabel LinkLabel;

CButton NewLongButton;
CButton NewShortButton;

CLabel RiskPercentageLabel;
CEdit RiskPercentageInput;
CLabel RiskMoneyLabel;
CEdit RiskMoneyInput;
CLabel LotSizeLabel;
CEdit LotSizeInput;

CButton ExecuteTradeButton;

//+------------------------------------------------------------------+
//| Manager initialization function                                  |
//+------------------------------------------------------------------+

int OnInit () {

   return CreateAppWindow();
}

int CreateAppWindow () {

   if(!AppWindow.Create(0, "SAFE TRADE SETUP MANAGER", 0, 30, 30, appWidth, appHeight)) { return INIT_FAILED; }
      
   ObjectSetInteger(0, "AppWindow", OBJPROP_COLOR, clrBlack);
      
   return CreateNewTradeLabel();

}

int CreateNewTradeLabel () { 

   if(!NewTradeLabel.Create(0, "NewTradeLabel", 0, 70, 10, 180, 30)) { return INIT_FAILED; }
   
   NewTradeLabel.Text("CREATE NEW TRADE");
   NewTradeLabel.Font(boldFontFamily);
   NewTradeLabel.FontSize(13);
   
   AppWindow.Add(NewTradeLabel);
   
   return CreateNewLongButton();
   
}

int CreateNewLongButton () {

   if(!NewLongButton.Create(0, "NewLongButton", 0, 10, 35, 10 + buttonLength, 75)) { return INIT_FAILED; }
   
   NewLongButton.Text("LONG");
   NewLongButton.Font(boldFontFamily);
   
   ObjectSetInteger(0, "NewLongButton", OBJPROP_BGCOLOR, clrGreen);
   ObjectSetInteger(0, "NewLongButton", OBJPROP_COLOR, clrWhite);
   ObjectSetInteger(0, "NewLongButton", OBJPROP_FONTSIZE, 17);
   
   
   AppWindow.Add(NewLongButton);

   return CreateNewShortButton();
   
}

int CreateNewShortButton () {

   if(!NewShortButton.Create(0, "NewShortButton", 0, 20 + buttonLength, 35, 147 + buttonLength, 75)) { return INIT_FAILED; }
   
   NewShortButton.Text("SHORT");
   NewShortButton.Font(boldFontFamily);
   
   ObjectSetInteger(0, "NewShortButton", OBJPROP_BGCOLOR, clrDarkRed);
   ObjectSetInteger(0, "NewShortButton", OBJPROP_COLOR, clrWhite);
   ObjectSetInteger(0, "NewShortButton", OBJPROP_FONTSIZE, 17);
   
   AppWindow.Add(NewShortButton);

   return CreateRiskManagementLabel();
   
}

int CreateRiskManagementLabel () { 

   if(!RiskPerTradeSettingsLabel.Create(0, "RiskPerTradeSettingsLabel", 0, 85, 83, appWidth - 40, 103)) { return INIT_FAILED; }
   
   RiskPerTradeSettingsLabel.Text("RISK PER TRADE");
   RiskPerTradeSettingsLabel.Font(boldFontFamily);
   RiskPerTradeSettingsLabel.FontSize(13);
   
   AppWindow.Add(RiskPerTradeSettingsLabel);
   
   return CreateLinkLabel();
   
}

int CreateLinkLabel () {
   
   int xPosition = (appWidth - 180) / 2;
   int yPosition = appHeight - 85;
   
   
   if(!LinkLabel.Create(0, "LinkLabel", 0, 70, yPosition, 180, 20)) { return INIT_FAILED; }
   
   LinkLabel.Text("KOVACSTRADING.COM");
   LinkLabel.FontSize(11);
   LinkLabel.Font(boldFontFamily);
   LinkLabel.Color(clrDarkGoldenrod);
   
   AppWindow.Add(LinkLabel);
   
   return CreateRiskPercentageLabel();
   
}

int CreateRiskPercentageLabel () {
   
   if(!RiskPercentageLabel.Create(0, "RiskPercentageLabel", 0, 14, 110, 80, 130)) { return INIT_FAILED; }
   
   RiskPercentageLabel.Text("ACCOUNT (%)");
   RiskPercentageLabel.FontSize(9);
   
   AppWindow.Add(RiskPercentageLabel);
   
   if(!RiskMoneyLabel.Create(0, "RiskMoneyLabel", 0, 128, 110, 190, 130)) { return INIT_FAILED; }
   
   RiskMoneyLabel.Text(AccountInfoString(ACCOUNT_CURRENCY));
   RiskMoneyLabel.FontSize(9);
   
   AppWindow.Add(RiskMoneyLabel);
   
   if(!LotSizeLabel.Create(0, "LotSizeLabel", 0, 205, 110, 280, 130)) { return INIT_FAILED; }
   
   LotSizeLabel.Text("LOT SIZE");
   LotSizeLabel.FontSize(9);
   
   AppWindow.Add(LotSizeLabel);

   return CreateRiskPercentageInput();

}

int CreateRiskPercentageInput () {
   
   if(!RiskPercentageInput.Create(0, "RiskPercentageInput", 0, 10, 135, 90, 157)) { return INIT_FAILED; }
   
   ObjectSetString(0, "RiskPercentageInput", OBJPROP_TEXT, DoubleToString(RiskPercentage, 0));
   ObjectSetInteger(0, "RiskPercentageInput", OBJPROP_ALIGN, ALIGN_CENTER);
   
   AppWindow.Add(RiskPercentageInput);
   
   if(!RiskMoneyInput.Create(0, "RiskMoneyInput", 0, 100, 135, 180, 157)) { return INIT_FAILED; }
   
   ObjectSetString(0, "RiskMoneyInput", OBJPROP_TEXT, DoubleToString(RiskMoney, 2));
   ObjectSetInteger(0, "RiskMoneyInput", OBJPROP_ALIGN, ALIGN_CENTER);
   
   AppWindow.Add(RiskMoneyInput);
   
   if(!LotSizeInput.Create(0, "LotSizeInput", 0, 190, 135, 270, 157)) { return INIT_FAILED; }
   
   LotSizeInput.ReadOnly(true);
   
   ObjectSetString(0, "LotSizeInput", OBJPROP_TEXT, "0.00");
   ObjectSetInteger(0, "LotSizeInput", OBJPROP_ALIGN, ALIGN_CENTER);
   
   AppWindow.Add(LotSizeInput);
   
   if(!ExecuteTradeButton.Create(0, "ExecuteTradeButton", 0, 10, 170, 271, 200)) { return INIT_FAILED; }
   
   ExecuteTradeButton.Text("EXECUTE TRADE");
   ExecuteTradeButton.Font(boldFontFamily);
   
   ObjectSetInteger(0, "ExecuteTradeButton", OBJPROP_BGCOLOR, clrBlack);
   ObjectSetInteger(0, "ExecuteTradeButton", OBJPROP_COLOR, clrWhite);
   ObjectSetInteger(0, "ExecuteTradeButton", OBJPROP_FONTSIZE, 15);
   
   
   AppWindow.Add(ExecuteTradeButton);
   
   ChartRedraw();

   return Success();

}

int Success () { AppWindow.Run(); return INIT_SUCCEEDED; }

//+------------------------------------------------------------------+
//| Manager chart event listener function                            |
//+------------------------------------------------------------------+

void OnChartEvent(const int id, const long &lParam, const double &dParam, const string &sParam) {

   AppWindow.ChartEvent(id, lParam, dParam, sParam);
   
   if(id == CHARTEVENT_OBJECT_CLICK && (sParam == "NewLongButton" || sParam == "NewShortButton")) { CreateNewTrade(sParam); }

}

//+------------------------------------------------------------------+
//| Manager deinitialization function                                |
//+------------------------------------------------------------------+

void OnDeinit (const int reason) {

   AppWindow.Destroy();
   
}

//+------------------------------------------------------------------+
//| Manager tick function                                            |
//+------------------------------------------------------------------+

void OnTick () {
   
  
   
}

//+------------------------------------------------------------------+
//| Manager create new trade function                                |
//+------------------------------------------------------------------+

void CreateNewTrade(string trade_executor) {

   double Price = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double StopLossPips = 0.00005;
   
   ENUM_TIMEFRAMES currentTimeframe = Period();
   
   if(currentTimeframe == PERIOD_M5) {
      StopLossPips = 0.00015;
   }
   
   if(currentTimeframe == PERIOD_M15) {
      StopLossPips = 0.00015;
   }
   
   if(currentTimeframe == PERIOD_M30) {
      StopLossPips = 0.00030;
   }
   
   if(currentTimeframe == PERIOD_H1) {
      StopLossPips = 0.00060;
   }
   
   if(currentTimeframe == PERIOD_H4) {
      StopLossPips = 0.00100;
   }
   
   if(currentTimeframe == PERIOD_H12) {
      StopLossPips = 0.00120;
   }
   
   if(currentTimeframe == PERIOD_D1) {
      StopLossPips = 0.00200;
   }
   
   if(currentTimeframe == PERIOD_W1) {
      StopLossPips = 0.00400;
   }
   
   if(currentTimeframe == PERIOD_MN1) {
      StopLossPips = 0.01000;
   }
   
   double TakeProfitPips = StopLossPips * 1.5;

   if(ObjectFind(0, "NewTradeEntryHLine") == -1) {
   
      ObjectCreate(0, "NewTradeEntryHLine", OBJ_HLINE, 0, TimeCurrent(), Price);
      
      ObjectSetInteger(0, "NewTradeEntryHLine", OBJPROP_STYLE, STYLE_SOLID);
      ObjectSetInteger(0, "NewTradeEntryHLine", OBJPROP_SELECTABLE, true);
      ObjectSetInteger(0, "NewTradeEntryHLine", OBJPROP_SELECTED, true);
      ObjectSetInteger(0, "NewTradeEntryHLine", OBJPROP_BACK, true);
      ObjectSetInteger(0, "NewTradeEntryHLine", OBJPROP_WIDTH, 1);
      ObjectSetInteger(0, "NewTradeEntryHLine", OBJPROP_COLOR, clrBlack);
      
   } else {
   
      ObjectSetDouble(0, "NewTradeEntryHLine", OBJPROP_PRICE, Price);
      
   }
   
   if(ObjectFind(0, "NewTradeStopLossHLine") == -1) {
   
      if(trade_executor == "NewLongButton") {
         ObjectCreate(0, "NewTradeStopLossHLine", OBJ_HLINE, 0, TimeCurrent(), Price - StopLossPips);
      } else if (trade_executor == "NewShortButton") {
         ObjectCreate(0, "NewTradeStopLossHLine", OBJ_HLINE, 0, TimeCurrent(), Price + StopLossPips);
      }
      
      ObjectSetInteger(0, "NewTradeStopLossHLine", OBJPROP_STYLE, STYLE_SOLID);
      ObjectSetInteger(0, "NewTradeStopLossHLine", OBJPROP_SELECTABLE, true);
      ObjectSetInteger(0, "NewTradeStopLossHLine", OBJPROP_SELECTED, true);
      ObjectSetInteger(0, "NewTradeStopLossHLine", OBJPROP_BACK, true);
      ObjectSetInteger(0, "NewTradeStopLossHLine", OBJPROP_WIDTH, 1);
      ObjectSetInteger(0, "NewTradeStopLossHLine", OBJPROP_COLOR, clrRed);
      
   } else {
   
      if(trade_executor == "NewLongButton") {
         ObjectSetDouble(0, "NewTradeStopLossHLine", OBJPROP_PRICE, Price - StopLossPips);
      } else if (trade_executor == "NewShortButton") {
         ObjectSetDouble(0, "NewTradeStopLossHLine", OBJPROP_PRICE, Price + StopLossPips);
      }
      
   }
   
   if(ObjectFind(0, "NewTradeTakeProfitHLine") == -1) {
   
      if(trade_executor == "NewLongButton") {
         ObjectCreate(0, "NewTradeTakeProfitHLine", OBJ_HLINE, 0, TimeCurrent(), Price + TakeProfitPips);
      } else if (trade_executor == "NewShortButton") {
         ObjectCreate(0, "NewTradeTakeProfitHLine", OBJ_HLINE, 0, TimeCurrent(), Price - TakeProfitPips);
      }
      
      ObjectSetInteger(0, "NewTradeTakeProfitHLine", OBJPROP_STYLE, STYLE_SOLID);
      ObjectSetInteger(0, "NewTradeTakeProfitHLine", OBJPROP_SELECTABLE, true);
      ObjectSetInteger(0, "NewTradeTakeProfitHLine", OBJPROP_SELECTED, true);
      ObjectSetInteger(0, "NewTradeTakeProfitHLine", OBJPROP_BACK, true);
      ObjectSetInteger(0, "NewTradeTakeProfitHLine", OBJPROP_WIDTH, 1);
      ObjectSetInteger(0, "NewTradeTakeProfitHLine", OBJPROP_COLOR, clrLightGreen);
      
   } else {
   
      if(trade_executor == "NewLongButton") {
         ObjectSetDouble(0, "NewTradeTakeProfitHLine", OBJPROP_PRICE, Price + TakeProfitPips);
      } else if (trade_executor == "NewShortButton") {
         ObjectSetDouble(0, "NewTradeTakeProfitHLine", OBJPROP_PRICE, Price - TakeProfitPips);
      }
      
   }
   
   ChartRedraw();
}

//+------------------------------------------------------------------+}