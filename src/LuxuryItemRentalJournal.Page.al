page 50216 "Luxury Item Rental Journal"
{
    Caption = 'Luxury Item Rental Journal';
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Rental Journal Line";
    
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Line No."; Rec."Line No.")
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
                field("Luxury Rental Item No."; Rec."Luxury Rental Item No.")
                {

                }
                field("Luxury Item Rental Unit No."; Rec."Luxury Item Rental Unit No.")
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
              
            }
        }
        // area(Factboxes)
        // {

        // }
    }

    actions
    {
        area(Processing)
        {
            group(Posting)
            {
                Caption = 'Posting';
                Image = Post;
                action(Post)
                {

                    Caption = 'Post';
                    Image = PostBatch;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related ledgers in your company books.';

                    trigger OnAction()
                    begin
                        CODEUNIT.Run(CODEUNIT::"Rental Jnl.-Post", Rec);

                        CurrPage.Update(false);
                    end;
                }
            }
        }
    }
}