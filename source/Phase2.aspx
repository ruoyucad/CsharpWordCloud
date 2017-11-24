<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Phase2.aspx.cs" Inherits="Phase2" enableEventValidation="false"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Lobster+Two" rel="stylesheet"/>
    <style>
        body{
                background-image: url("image/Hexagon-1.jpg");               
            }
        h1 {
               text-align:center;
               font-family:'Lobster Two', cursive;
           }    
    </style> 
  
</head>
     
<body>
    
    <!--*****************************************try above ****************************************************************** -->
    <div>
    <form class="col-md-12" id="form3" runat="server">
    <h1>What the Fuzz !</h1>
    <br />     
            <div class="container-fluid">
                <div class='jumbotron text-center' style="border:1px #ccc; box-shadow:0px 2px 5px #ccc; height:234px;">
                    Who is Talking ? :&nbsp;&nbsp;                                   
                    <asp:TextBox runat="server" id="text3" type="text" Width="248px" />     
                    <br/>  
                    <br/>
                    How many tweets ? 
                    <asp:TextBox runat="server" id="text4" type="text" Width="248px" />
                    <br />
                    <br />
                    (Due to Twitter Regulation, 200 Tweets Max per search)
                    <br />
                    <br/>  
                    <asp:Button ID="Button3" class="btn btn-info" runat="server" Height="39px" OnClick="Button1_Click"  Text="Search" Width="98px" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="Button1" class="btn btn-info" runat="server" Text="Reset" OnClick="Reset_Click" Height="38px" Width="102px" />
                </div>
            </div> 
        <br />
        
            <asp:TextBox ID="TextBox2" runat="server" Height="490px" Width="1311px" BorderStyle="Solid" TextMode="MultiLine" name="result"></asp:TextBox>   
            
        <br />
        <br />
&nbsp;
        <asp:Button ID="Button2" class="btn btn-success" runat="server" Text="Generate !" OnClick="Button2_Click" />

    </form>
       
   </div> 
</body>
</html>
