page 50218 "Luxury Rental Ledger Entries"
{
    PageType = List;
    Editable = false;
    ApplicationArea = All;
    UsageCategory = History;
    SourceTable = "Luxury Rental Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Line No."; Rec."Entry No.") //Entry No.
                {
                }
                field("Entry Type"; Rec."Entry Type")
                {

                }
                field("Document No."; Rec."Document No.")
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Rental Order No."; Rec."Rental Order No.")
                {

                }
                field("Customer No."; Rec."Customer No.")
                {

                }
                field("Rental Asset No."; Rec."Rental Asset No.")
                {

                }
                field("Rental Asset Unit No."; Rec."Rental Asset Unit No.")
                {

                }
                Field("Rental Start"; Rec."Rental Start")
                {
                }
                Field("Rental End"; Rec."Rental End")
                {
                }
                Field("Rental Days"; Rec."Rental Days")
                {
                }
                Field("Days (Expected)"; Rec."Days (Expected)")
                {
                }
                Field("Days (Actual)"; Rec."Days (Actual)")
                {
                }
                Field("(Invoiced)"; Rec."Days (Invoiced)")
                {
                }

            }
        }
        // area(Factboxes)
        // {

        // }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {
    //             ApplicationArea = All;

    //             trigger OnAction();
    //             begin

    //             end;
    //         }
    //     }
    // }
}