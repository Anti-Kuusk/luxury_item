page 50205 "Luxury Item List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Luxury Item";
    Editable = false;
    CardPageId = "Luxury Item Card";


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                  ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the rental asset.';

                }
                field("Search Description"; Rec."Search Description")
                {
                    ToolTip = 'Specifies a search description for the rental asset.';
                }
                field("Luxury Item Category Code"; Rec."Luxury Item Category Code")
                {
                    ToolTip = 'Specifies the class that the rental asset belongs to';

                }
                field(Brand; Rec.Brand)
                {

                }
                field(Model; Rec.Model)
                {

                }
                field(Material; Rec.Material)
                {

                }
                field(Price; Rec.Price)
                {

                }
                field(Color; Rec.Color)
                {

                }
                field("Responsible Employee"; Rec."Responsible Employee")
                {
                    
                }
             
                field(Blocked; Rec.Blocked)
                {

                }
            }
        }
        // area(Factboxes)
        // {
        //      systempart(Control1900383207; Links)
        //     {
        //         ApplicationArea = RecordLinks;
        //         Visible = false;
        //     }
        //     systempart(Control1905767507; Notes)
        //     {
        //         ApplicationArea = Notes;
        //     }

        // }
    }

    actions
    {
        // area(Processing)
        // {
        //     action(ActionName)
        //     {
        //         ApplicationArea = All;

        //         trigger OnAction();
        //         begin

        //         end;
        //     }
        // }
    }
}