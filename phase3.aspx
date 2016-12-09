<%@ Page Language="C#" AutoEventWireup="true" CodeFile="phase3.aspx.cs" Inherits="phase3" enableEventValidation="false" %>

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
    <form  class="col-md-12" id="form1" runat="server">
        <br />
        <br />
    <div>
        <asp:TextBox ID="TextBox1" runat="server" Height="431px" TextMode="MultiLine" Width="1091px"></asp:TextBox>
        <br />
    </div>
        <span class=" glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>
       
         &nbsp;&nbsp;
         <button type="button" class="btn btn-success" value="save" id="save"> Save</button>
        
<%-- SAVING FILE      --%> 
        <script>
             function saveTextAsFile()
                    {
                        var textToWrite = document.getElementById('TextBox1').value;
                        var textFileAsBlob = new Blob([textToWrite], {type:'text/plain'});
                        var fileNameToSaveAs = "tweets.txt";
        
                        var downloadLink = document.createElement("a");
                        downloadLink.download = fileNameToSaveAs;
                        downloadLink.innerHTML = "Download File";
                        if (window.webkitURL != null)
                        {
                            // Chrome allows the link to be clicked
                            // without actually adding it to the DOM.
                            downloadLink.href = window.webkitURL.createObjectURL(textFileAsBlob);
                        }
                        else
                        {
                            // Firefox requires the link to be added to the DOM
                            // before it can be clicked.
                            downloadLink.href = window.URL.createObjectURL(textFileAsBlob);
                            downloadLink.onclick = destroyClickedElement;
                            downloadLink.style.display = "none";
                            document.body.appendChild(downloadLink);
                        }
        
                        downloadLink.click();
                    }
    
                    var button = document.getElementById('save');
                    button.addEventListener('click', saveTextAsFile);
        </script>
<%-- SAVING FILE      --%>         
        <br />        
    </form>
<%--SHOWING WORDCLOUD--%>
    <script src="http://d3js.org/d3.v3.min.js"></script>
  <script src="https://rawgit.com/jasondavies/d3-cloud/master/build/d3.layout.cloud.js"></script>
  <script>
// Encapsulate the word cloud functionality
function wordCloud(selector) {
    var fill = d3.scale.category20();

    //Construct the word cloud's SVG element
    var svg = d3.select(selector).append("svg")
        .attr("width", 500)
        .attr("height", 500)
        .append("g")
        .attr("transform", "translate(250,250)");


    //Draw the word cloud
    function draw(words) {
        var cloud = svg.selectAll("g text")
                        .data(words, function(d) { return d.text; })

        //Entering words
        cloud.enter()
            .append("text")
            .style("font-family", "Impact")
            .style("fill", function(d, i) { return fill(i); })
            .attr("text-anchor", "middle")
            .attr('font-size', 1)
            .text(function(d) { return d.text; });

        //Entering and existing words
        cloud
            .transition()
                .duration(600)
                .style("font-size", function(d) { return d.size + "px"; })
                .attr("transform", function(d) {
                    return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
                })
                .style("fill-opacity", 1);

        //Exiting words
        cloud.exit()
            .transition()
                .duration(200)
                .style('fill-opacity', 1e-6)
                .attr('font-size', 1)
                .remove();
    }


    //Use the module pattern to encapsulate the visualisation code. We'll
    // expose only the parts that need to be public.
    return {

        //Recompute the word cloud for a new set of words. This method will
        // asycnhronously call draw when the layout has been computed.
        //The outside world will need to call this function, so make it part
        // of the wordCloud return value.
        update: function(words) {
            d3.layout.cloud().size([500, 500])
                .words(words)
                .padding(5)
                .rotate(function() { return ~~(Math.random() * 2) * 90; })
                .font("Impact")
                .fontSize(function(d) { return d.size; })
                .on("end", draw)
                .start();
        }
    }

}

      //Some sample data - 
var tweets = document.getElementById("TextBox1").value;
var words = new Array();

function ExtractArray()
{

    var specialDelimiter = "--..--";

    words = tweets.split(specialDelimiter);

}

//var words = ["No.1Tweets: Dolly Parton wants to give $1,000 a month for six months to every family affected by the Tennessee wildfires… ",
//"No.2Tweets: This photo shows the toll that the Gatlinburg wildfires take on those fighting them",
//"No.3Tweets: Martin Shkreli meets his match in group of Australian schoolboys who recreated lifesaving drug for just $20 a",
//"No.4Tweets: Hackers have gained access to 1.3 million Google accounts by infecting Android phones through illegitimate ",
//"No.5Tweets: 6 million borrowers are at least 90 days late on their car loans ",
//"No.6Tweets: This claim from a Trump supporter left CNN anchor @alisyncamerota stunned ",
//"No.7Tweets: Committee recommends firing the judge who asked woman in rape case why she couldn't keep knees together",
//"No.8Tweets: Rep. Keith Ellison faces renewed scrutiny over past ties to Nation of Islam, defense of anti-Semitic figures ",
//"No.9Tweets: CNN SPECIAL REPORT: An enormous ",
//"No.10Tweets: How to help those affected by Tennessee wildfires "]

//Prepare one of the sample sentences by removing punctuation,
// creating an array of words and computing a random size attribute.
function getWords(i) {

    return words[i]
            .replace(/[!\.,:;\?]/g, '')
            .split(' ')
            .map(function(d) {
                return {text: d, size: 10 + Math.random() * 60};
            })
}

//This method tells the word cloud to redraw with a new set of words.
//In reality the new words would probably come from a server request,
// user input or some other source.
function showNewWords(vis, i) {
    i = i || 0;

    vis.update(getWords(i ++ % words.length))
    setTimeout(function() { showNewWords(vis, i + 1)}, 2000)
}

//Create a new instance of the word cloud visualisation.
var myWordCloud = wordCloud('body');
ExtractArray();
document.getElementById("TextBox1").value = words[0];

//Start cycling through the demo data
showNewWords(myWordCloud);


</script>
<%--SHOWING WORDCLOUD--%>
</body>
</html>
