program Smeta;

{$SETPEFlAGS $0001}

uses
  Forms,
  Windows,
  ShellAPI,
  DataModule in 'DataModule.pas' {DM: TDataModule},
  Main in 'Main.pas' {FormMain},
  TariffsSalary in 'TariffsSalary.pas' {FormTariffsSalary},
  TariffsMechanism in 'TariffsMechanism.pas' {FormTariffsMechanism},
  TariffsDump in 'TariffsDump.pas' {FormTariffsDump},
  TariffsIndex in 'TariffsIndex.pas' {FormTariffsIndex},
  About in 'About.pas' {FormAbout},
  CalculationEstimate in 'CalculationEstimate.pas' {FormCalculationEstimate},
  ConnectDatabase in 'ConnectDatabase.pas' {FormConnectDatabase},
  CardObject in 'CardObject.pas' {FormCardObject},
  ProgramSettings in 'ProgramSettings.pas' {FormProgramSettings},
  Login in 'Login.pas' {FormLogin},
  Waiting in 'Waiting.pas' {FormWaiting},
  KC6 in 'KC6.pas' {FormKC6},
  ActC6 in 'ActC6.pas' {FormActC6},
  WorkSchedule in 'WorkSchedule.pas' {FormWorkSchedule},
  HelpC3 in 'HelpC3.pas' {FormHelpC3},
  Requisites in 'Requisites.pas' {FormRequisites},
  HelpC5 in 'HelpC5.pas' {FormHelpC5},
  CatalogSSR in 'CatalogSSR.pas' {FormCatalogSSR},
  OXRandOPR in 'OXRandOPR.pas' {FormOXRandOPR},
  WinterPrice in 'WinterPrice.pas' {FormWinterPrice},
  Columns in 'Columns.pas' {FormColumns},
  SignatureSSR in 'SignatureSSR.pas' {FormSignatureSSR},
  SummaryCalculationSettings in 'SummaryCalculationSettings.pas' {FormSummaryCalculationSettings},
  DataTransfer in 'DataTransfer.pas' {FormDataTransfer},
  CalculationSettings in 'CalculationSettings.pas' {FormCalculationSettings},
  Coefficients in 'Coefficients.pas' {FormCoefficients},
  BasicData in 'BasicData.pas' {FormBasicData},
  CardEstimate in 'CardEstimate.pas' {FormCardEstimate},
  ObjectsAndEstimates in 'ObjectsAndEstimates.pas' {FormObjectsAndEstimates},
  PercentClientContractor in 'PercentClientContractor.pas' {FormPercentClientContractor},
  Transportation in 'Transportation.pas' {FormTransportation},
  SaveEstimate in 'SaveEstimate.pas' {FormSaveEstimate},
  OwnData in 'OwnData.pas' {FormOwnData},
  fFrameProgressBar in 'fFrameProgressBar.pas' {FrameProgressBar: TFrame},
  DrawingTables in 'DrawingTables.pas',
  fFrameSmeta in 'fFrameSmeta.pas' {SmetaFrame: TFrame},
  fFrameStatusBar in 'fFrameStatusBar.pas' {FrameStatusBar: TFrame},
  fFrameEquipments in 'fFrameEquipments.pas' {FrameEquipment: TFrame},
  fFrameOXROPR in 'fFrameOXROPR.pas' {FrameOXROPR: TFrame},
  fFramePriceMaterials in 'fFramePriceMaterials.pas' {FramePriceMaterial: TFrame},
  fFramePriceMechanizms in 'fFramePriceMechanizms.pas' {FramePriceMechanizm: TFrame},
  fFramePriceDumps in 'fFramePriceDumps.pas' {FramePriceDumps: TFrame},
  fFramePriceTransportations in 'fFramePriceTransportations.pas' {FramePriceTransportations: TFrame},
  fFrameWinterPrice in 'fFrameWinterPrice.pas' {FrameWinterPrice: TFrame},
  fFrameRates in 'fFrameRates.pas' {FrameRates: TFrame},
  fFrameSSR in 'fFrameSSR.pas' {FrameSSR: TFrame},
  TariffsTransportanion in 'TariffsTransportanion.pas' {FormTariffsTransportation},
  ReplacementMaterial in 'ReplacementMaterial.pas' {FormReplacementMaterial},
  ReferenceData in 'ReferenceData.pas' {FormReferenceData},
  PricesOwnData in 'PricesOwnData.pas' {FormPricesOwnData},
  PricesReferenceData in 'PricesReferenceData.pas' {FormPricesReferenceData},
  AdditionData in 'AdditionData.pas' {FormAdditionData},
  Materials in 'Materials.pas' {FormMaterials},
  CardMaterial in 'CardMaterial.pas' {FormCardMaterial},
  CardDataEstimate in 'CardDataEstimate.pas' {FormCardDataEstimate},
  ListCollections in 'ListCollections.pas' {FormListCollections},
  CardOrganization in 'CardOrganization.pas' {FormCardOrganization},
  fTypesActs in 'fTypesActs.pas' {FrameTypesActs: TFrame},
  fIndexesChangeCost in 'fIndexesChangeCost.pas' {FrameIndexesChangeCost: TFrame},
  fCategoriesObjects in 'fCategoriesObjects.pas' {FrameCategoriesObjects: TFrame},
  PartsEstimates in 'PartsEstimates.pas' {FormPartsEstimates},
  fPartsEstimates in 'fPartsEstimates.pas' {FramePartsEstimates: TFrame},
  fSectionsEstimates in 'fSectionsEstimates.pas' {FrameSectionsEstimates: TFrame},
  fTypesWorks in 'fTypesWorks.pas' {FrameTypesWorks: TFrame},
  SetCoefficients in 'SetCoefficients.pas' {FormSetCoefficients},
  fCoefficientsRates in 'fCoefficientsRates.pas' {FrameCoefficientsRates_TODEL: TFrame},
  Organizations in 'Organizations.pas' {FormOrganizations},
  fOrganizations in 'fOrganizations.pas' {FrameOrganizations: TFrame},
  SectionsEstimates in 'SectionsEstimates.pas' {FormSectionsEstimates},
  TypesWorks in 'TypesWorks.pas' {FormTypesWorks},
  TypesActs in 'TypesActs.pas' {FormTypesActs},
  IndexesChangeCost in 'IndexesChangeCost.pas' {FormIndexesChangeCost},
  CategoriesObjects in 'CategoriesObjects.pas' {FormCategoriesObjects},
  CardCoefficients in 'CardCoefficients.pas' {FormCardCoefficients},
  CardTypesActs in 'CardTypesActs.pas' {FormCardTypesActs},
  CardIndexesChangeCost in 'CardIndexesChangeCost.pas' {FormCardIndexesChangeCost},
  CardCategoriesObjects in 'CardCategoriesObjects.pas' {FormCardCategoriesObjects},
  CardPartsEstimates in 'CardPartsEstimates.pas' {FormCardPartsEstimates},
  CardSectionsEstimates in 'CardSectionsEstimates.pas' {FormCardSectionsEstimates},
  CardTypesWorks in 'CardTypesWorks.pas' {FormCardTypesWorks},
  CoefficientOrders in 'CoefficientOrders.pas' {FormCoefficientOrders},
  CardAct in 'CardAct.pas' {fCardAct},
  Tools in 'Tools.pas',
  Vcl.Themes,
  Vcl.Styles,
  KC6Journal in 'KC6Journal.pas' {fKC6Journal},
  CalculationEstimateSummaryCalculations in 'CalculationEstimateSummaryCalculations.pas' {frCalculationEstimateSummaryCalculations: TFrame},
  CalculationEstimateSSR in 'CalculationEstimateSSR.pas' {frCalculationEstimateSSR: TFrame},
  CalcResource in 'CalcResource.pas' {fCalcResource},
  CalculationDump in 'CalculationDump.pas' {FormCalculationDump},
  CalcTravel in 'CalcTravel.pas' {fCalcTravel},
  UniDict in 'UniDict.pas' {fUniDict},
  UpdateModule in 'UpdateModule.pas',
  TravelList in 'TravelList.pas' {fTravelList},
  CardPTM in 'CardPTM.pas' {FormCardPTM},
  fUpdate in 'fUpdate.pas' {UpdateForm},
  EditExpression in 'EditExpression.pas' {fEditExpression},
  dmReportU in 'dmReportU.pas' {dmReportF: TDataModule},
  Coef in 'Coef.pas' {fCoefficients},
  ArhivModule in 'ArhivModule.pas';

{$R *.res}
var MHandle: THandle;
begin
  // Любая уникальная строка которая будет только в нашем приложении
  MHandle := CreateMutex(nil, False, '5q7b3g1p0b5n3x6v9e6s');

  // Проверяем не запущено ли приложение
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    MessageBox(0, 'Одна копия программы уже открыта.' + sLineBreak + sLineBreak +
      'Запуск нескольких копий программы невозможен.', 'Расчёт сметы', MB_ICONWARNING + mb_OK + mb_TaskModal);
    Exit;
  end;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Смета';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.CreateForm(TFormConnectDatabase, FormConnectDatabase);
  Application.CreateForm(TFormCardObject, FormCardObject);
  Application.CreateForm(TFormProgramSettings, FormProgramSettings);
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormWaiting, FormWaiting);
  Application.CreateForm(TFormRequisites, FormRequisites);
  Application.CreateForm(TFormColumns, FormColumns);
  Application.CreateForm(TFormSignatureSSR, FormSignatureSSR);
  Application.CreateForm(TFormSummaryCalculationSettings, FormSummaryCalculationSettings);
  Application.CreateForm(TFormCalculationSettings, FormCalculationSettings);
  Application.CreateForm(TFormCoefficients, FormCoefficients);
  Application.CreateForm(TFormBasicData, FormBasicData);
  Application.CreateForm(TFormCardEstimate, FormCardEstimate);
  Application.CreateForm(TFormPercentClientContractor, FormPercentClientContractor);
  Application.CreateForm(TFormSaveEstimate, FormSaveEstimate);
  Application.CreateForm(TFormCardMaterial, FormCardMaterial);
  Application.CreateForm(TFormCardDataEstimate, FormCardDataEstimate);
  Application.CreateForm(TFormListCollections, FormListCollections);
  Application.CreateForm(TFormCardOrganization, FormCardOrganization);
  Application.CreateForm(TFormCardCoefficients, FormCardCoefficients);
  Application.CreateForm(TFormTypesActs, FormTypesActs);
  Application.CreateForm(TFormCardTypesActs, FormCardTypesActs);
  Application.CreateForm(TFormCardIndexesChangeCost, FormCardIndexesChangeCost);
  Application.CreateForm(TFormIndexesChangeCost, FormIndexesChangeCost);
  Application.CreateForm(TFormCardCategoriesObjects, FormCardCategoriesObjects);
  Application.CreateForm(TFormCategoriesObjects, FormCategoriesObjects);
  Application.CreateForm(TFormCardPartsEstimates, FormCardPartsEstimates);
  Application.CreateForm(TFormCardSectionsEstimates, FormCardSectionsEstimates);
  Application.CreateForm(TFormCardTypesWorks, FormCardTypesWorks);
  Application.CreateForm(TFormCoefficientOrders, FormCoefficientOrders);
  Application.CreateForm(TFormKC6, FormKC6);
  Application.CreateForm(TFormCardPTM, FormCardPTM);
  Application.CreateForm(TdmReportF, dmReportF);
  Application.CreateForm(TfCoefficients, fCoefficients);
  Application.Run;

  //Запуск Updater для завершения обновления приложения
  if StartUpdater then
    ShellExecute(0,'open', Pchar(UpdaterName),
      Pchar(UpdatePath + ' ' + NewAppVersion), nil ,SW_HIDE);

  ReleaseMutex(MHandle);
  CloseHandle(MHandle);
end.
