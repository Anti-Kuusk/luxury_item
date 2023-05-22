page 50213 "Luxury Item Card"
{
    Caption = 'Luxury Item Card';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Luxury Item";

    layout
    {
        area(Content)
        {

            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;

                }
                field(Description; Rec.Description)
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies a description of the rental asset.';

                }
                field("Search Description"; Rec."Search Description")
                {
                    ToolTip = 'Specifies a search description for the rental asset.';

                }
                field("Luxury Item Category code"; Rec."Luxury Item Category code")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the category that the rental asset belongs to.';

                }
                field("Brand"; Rec."Brand")
                {

                }
                field(Model; Rec.Model)
                {

                }
                field(Color; Rec.Color)
                {

                }
                field(Material; Rec.Material)
                {

                }
                field(Price; Rec.Price)
                {

                }

                field(Blocked; Rec.Blocked)
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example a customer that is declared insolvent or an item that is placed in quarantine.';

                }
                field("No. Series"; Rec."No. Series")
                {

                }
                field("Responsible Employee"; Rec."Responsible Employee")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies which employee is responsible for the rental asset.';
                }
            }

            part(RentalAssetUnit; "Luxury Item Rental Subpage")
            {
                ApplicationArea = All;
                Caption = 'Rental Asset Units';
                SubPageLink = "Luxury Item No." = FIELD("No.");
            }

        }
    }

    actions
    {
        area(Processing)
        {
            // action(ActionName)
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     begin

            //     end;
            // }
        }
    }

    var
    //         myInt: Integer;
}