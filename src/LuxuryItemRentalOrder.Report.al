report 50216 "Luxury Item Rental Order"
{
    Caption = 'Luxury Item Rental Order';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = WordLayout;

   // WordLayout = './RentalOrder.docx';
   // DefaultLayout = Word;
    PreviewMode = PrintLayout;
    WordMergeDataItem = RentalOrder;

    dataset
    {
        dataitem(RentalOrder; "Luxury Item Rental Order")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Customer No.", "Rental Item No.", "Rental Item Unit No.";



            column(No; "No.")
            {

            }
            column(RentalStart; "Rental Start")
            {
            }
            column(RentalEnd; "Rental End")
            {
            }
            column(RentalDays; "Rental Days")
            {
            }
            column(NoSeries; "No. Series")
            {

            }
            column(Status; Status)
            {

            }
            column(CustomerNo; "Customer No.")
            {

            }
            column(CustomerName; "Customer Name")
            {

            }


            column(RentalAssetNo; "Rental Item No.")
            {

            }
            column(RentalAssetDescription; "Luxury Item Description")
            {

            }
            column(RentalAssetUnitNo; "Rental Item Unit No.")
            {

            }
            column(RentalAssetUnitDescription; "Luxury Item Description")
            {

            }
        }
    }
        rendering
    {
        layout(WordLayout)
        {
            Type = Word;
            LayoutFile = './src/Layout/RentalOrder.docx';
        }
    
    }



}