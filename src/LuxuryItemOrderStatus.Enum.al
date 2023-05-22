enum 50211 "Luxury Item Rental Order Status"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; Open) { Caption = 'Open'; }
    value(1; Released) { Caption = 'Released'; }
    value(2; "Pending Approval") { Caption = 'Pending Approval'; }
    value(3; "Pending Prepayment") { Caption = 'Pending Prepayment'; }
    value(4; "Closed") { Caption = 'Closed'; }
}