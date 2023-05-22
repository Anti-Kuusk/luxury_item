page 50215 "Luxury Item Rental Order"
{
    Caption = 'Luxury Item Rental Order';
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Luxury Item Rental Order";

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
                field(Status; Rec.Status)
                {

                }
                field("Customer No."; Rec."Customer No.")
                {

                }
                field("Customer Name"; Rec."Customer Name")
                {

                }

                field("No. Series"; Rec."No. Series")
                {

                }
            }

            group(RentalAsset)
            {
                Caption = 'Rental Asset';

                field("Rental Item No."; Rec."Rental Item No.")
                {
                    ShowMandatory = true;
                }
                field("Luxury Item Description"; Rec."Luxury Item Description")
                {

                }
                field("Luxury Item Category"; Rec."Luxury Item Category")
                {

                }
                field("Luxury Item Rental Price"; Rec."Luxury Item Rental Price")
                {

                }
                field("Rental Item Unit No."; Rec."Rental Item Unit No.")
                {
                    

                }
            }
            group(RentalPeriod)
            {
                Caption = 'Rental Period';
                Field("Rental Start"; Rec."Rental Start")
                {
                    ShowMandatory = true;
                }
                Field("Rental End"; Rec."Rental End")
                {
                    ShowMandatory = true;
                }
                Field("Rental Days"; Rec."Rental Days")
                {
                    ShowMandatory = true;
                }
                Field("Total amount"; Rec."Total amount")
                {
                    
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Release)
            {
                Caption = 'Release Order';

                trigger OnAction()
                begin
                    Rec.ReleaseOrder();
                end;
            }
            action(Reopen)
            {
                Caption = 'Reopen Order';

                trigger OnAction()
                begin
                    Rec.ReOpenOrder()
                end;
            }
            group("Posting")
            {
                Caption = 'Posting';
                Image = Post;
                action("Post")
                {
                    Caption = 'Post';
                    Ellipsis = true;
                    Image = PostOrder;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related ledgers (andmikesse) in your company books.';

                    trigger OnAction()
                    begin
                        CODEUNIT.Run(CODEUNIT::"Rental-Post (Yes/No)", Rec);
                    end;
                }
            }
        }
        area(Reporting)
        {
            action(PrintOrder)
            {
                Caption = 'Print Order';

                trigger OnAction()
                begin
                    Rec.PrintOrder();
                end;
            }

        }
    }




    var
    //         myInt: Integer;
}