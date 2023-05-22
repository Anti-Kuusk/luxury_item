page 50212 "Luxury Item Rental Orders"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Luxury Item Rental Order";
    Editable = false;
    CardPageId = "Luxury Item Rental Order";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {

                }
                field("Customer No."; Rec."Customer No.")
                {

                }
                field(Status; Rec.Status)
                {

                }
                

            }
          
        }
        area(Factboxes)
        {

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
            action(Print)
            {
                Caption = 'Print Order';

                trigger OnAction()
                begin
                    Rec.PrintOrder();
                end;
            }
        }
    }
}