using Newtonsoft.Json.Linq;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



public partial class Phase2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
       


    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        
        var oauth_token = "497959136-xUUkBG5fqmVJKY7XJUJ7vz19eUcSxkfDJywNqHcI";
        var oauth_token_secret = "jWuV72DH4KhL99ywBJxztTglYP8VckDxD1a92Ds71pOpC";
        var oauth_consumer_key = "rS2fgHdSlWYECWXXzkTsHjkPf";
        var oauth_consumer_secret = "WMwE020XPCBwXHDvnVVo6JMap2ULlAMtV2uSYlNgxvzwl3VfT5";

        // oauth implementation details
        var oauth_version = "1.0";
        var oauth_signature_method = "HMAC-SHA1";

        // unique request details
        var oauth_nonce = Convert.ToBase64String(
            new ASCIIEncoding().GetBytes(DateTime.Now.Ticks.ToString()));
        var timeSpan = DateTime.UtcNow
            - new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
        var oauth_timestamp = Convert.ToInt64(timeSpan.TotalSeconds).ToString();

        // message api details
        var status = "Updating status via REST API if this works";
        var resource_url = "https://api.twitter.com/1.1/statuses/user_timeline.json";
        var screen_name = text3.Text;
        var count = text4.Text;
        // create oauth signature
        var baseFormat = "count={7}&oauth_consumer_key={0}&oauth_nonce={1}&oauth_signature_method={2}"
            + "&oauth_timestamp={3}&oauth_token={4}&oauth_version={5}&screen_name={6}";

        var baseString = string.Format(baseFormat,
                                    oauth_consumer_key,
                                    oauth_nonce,
                                    oauth_signature_method,
                                    oauth_timestamp,
                                    oauth_token,
                                    oauth_version,
                                     Uri.EscapeDataString(screen_name),
                                     Uri.EscapeDataString(count)
                                    );

        baseString = string.Concat("GET&", Uri.EscapeDataString(resource_url), "&", Uri.EscapeDataString(baseString));

        var compositeKey = string.Concat(Uri.EscapeDataString(oauth_consumer_secret),
                                "&", Uri.EscapeDataString(oauth_token_secret));

        string oauth_signature;
        using (HMACSHA1 hasher = new HMACSHA1(ASCIIEncoding.ASCII.GetBytes(compositeKey)))
        {
            oauth_signature = Convert.ToBase64String(
                hasher.ComputeHash(ASCIIEncoding.ASCII.GetBytes(baseString)));
        }

        // create the request header
        var headerFormat = "OAuth oauth_nonce=\"{0}\", oauth_signature_method=\"{1}\", " +
                           "oauth_timestamp=\"{2}\", oauth_consumer_key=\"{3}\", " +
                           "oauth_token=\"{4}\", oauth_signature=\"{5}\", " +
                           "oauth_version=\"{6}\"";

        var authHeader = string.Format(headerFormat,
                                Uri.EscapeDataString(oauth_nonce),
                                Uri.EscapeDataString(oauth_signature_method),
                                Uri.EscapeDataString(oauth_timestamp),
                                Uri.EscapeDataString(oauth_consumer_key),
                                Uri.EscapeDataString(oauth_token),
                                Uri.EscapeDataString(oauth_signature),
                                Uri.EscapeDataString(oauth_version)
                        );


        // make the request

        ServicePointManager.Expect100Continue = false;

        var postBody = "screen_name=" + Uri.EscapeDataString(screen_name);//
        var postbody2 = "count=" + Uri.EscapeDataString(count);
        resource_url += "?" + postBody + "&" + postbody2;
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(resource_url);
        request.Headers.Add("Authorization", authHeader);
        request.Method = "GET";
        request.ContentType = "application/x-www-form-urlencoded";
        WebResponse response = request.GetResponse();
        string responseData = new StreamReader(response.GetResponseStream()).ReadToEnd();
        //convert json string to jarray
        JArray jsonDat = JArray.Parse(responseData);
        //text3.Text = jsonDat.Count().ToString();

        string tempTestString = "";
        string specialDelimiter = "--..--";

        for (int x = 0; x < jsonDat.Count(); x++)
        {
            JObject tweet = JObject.Parse(jsonDat[x].ToString());
            string tweettext = tweet["text"].ToString();
            //string tweettime = tweet["created_at"].ToString();            
            //string rtNumber = tweet["retweet_count"].ToString();
            //whatever else you want to look up

            TextBox2.Text += "\"" +"No."+ (x+1) + "Tweets: " + tweettext  +"\"" + ","+"\n";
            Session["tweets"] = TextBox2.Text;
            tempTestString += tweettext;
            tempTestString += specialDelimiter;

        }
        Session.Add("tempTestString", tempTestString);
       
    }

        protected void Reset_Click(object sender, EventArgs e)
    {
        text3.Text = string.Empty;
        text4.Text = string.Empty;
        TextBox2.Text = string.Empty;
        // so on youe all controls
    }


    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("phase3.aspx");
    }
}
