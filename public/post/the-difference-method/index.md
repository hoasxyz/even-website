
<script src="/rmarkdown-libs/kePrint/kePrint.js"></script>
<script src="/rmarkdown-libs/jquery/jquery.min.js"></script>
<script src="/rmarkdown-libs/detect-resize/jquery.resize.js"></script>
<link href="/rmarkdown-libs/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
<script src="/rmarkdown-libs/jquery-ui/jquery-ui.min.js"></script>
<script src="/rmarkdown-libs/d3/d3.min.js"></script>
<script src="/rmarkdown-libs/vega/vega.min.js"></script>
<script src="/rmarkdown-libs/lodash/lodash.min.js"></script>
<script>var lodash = _.noConflict();</script>
<link href="/rmarkdown-libs/ggvis/css/ggvis.css" rel="stylesheet" />
<script src="/rmarkdown-libs/ggvis/js/ggvis.js"></script>


<blockquote>
<p>The question is solved with R and this report is made by R Markdown. One of the reasons is that they are both in RStudio, which is new to me and I want to try. In R Markdown, the Chinese characters are so ugly and glare so I decided to use English to convey what I want to express. This is my first report written in English and shaped by R with R Markdown!</p>
</blockquote>
<div id="explicit-difference-method" class="section level1">
<h1>Explicit Difference Method</h1>
<p>Flowing is the code chunk based on the explicit difference method, most codes of which are in a function named <code>calex</code> and you can call <code>calex</code> function to solve the problems with alternative different parameters. And you can change the parameters as you want.</p>
<p>I use backward difference method because it is easily for codeing, comparing to central difference method which is mainly discussed in class. What you should do is just adding one column named <em>x = -1</em> in the initial data frame.</p>
<pre class="r"><code># Backward Difference Method
calex &lt;- function(dx,dt,BOD,x = 8,u = 5,E = 2, k1 = 0.0151,t = 1,plot = FALSE) {
  col &lt;- x/dx+3; row &lt;- t/dt+1; name &lt;- c(&#39;t&#39;,seq(-1,x,dx))
  alpha &lt;- E*dt/dx^2; beta &lt;- u*dt/dx-2*dt*E/dx^2-k1*dt; gamma &lt;- 1-u*dt/dx+E*dt/dx^2
  ex &lt;- rep(0,row*col);attr(ex,&quot;dim&quot;) &lt;- c(row,col); ex &lt;- as.tibble(ex)
  ex[,1] &lt;- seq(0.0,t,dt); ex[,2] &lt;- BOD; ex[,3] &lt;- BOD
  if (dt*u/dx &lt;= 1 &amp;&amp; E*dt/dx^2&lt;= 0.5) {
    for (j in 1:(t/dt)) for (i in 1:(x/dx)) 
      ex[j+1,i+3] &lt;- alpha*ex[j,i+1]+beta*ex[j,i+2]+gamma*ex[j,i+3]
    if (plot) {
      names(ex) &lt;- name
      pex &lt;- ex %&gt;%
        dplyr::filter(t != 0) %&gt;%
        melt(id = &quot;t&quot;,variable.name = &quot;x&quot;,value.name = &quot;BOD&quot;) %&gt;%
        dplyr::filter(x != -1) %&gt;%
        ggvis(~x,~t) %&gt;%
        layer_points(size:=~factor(BOD*25))
      return(list(ex,pex))
    } else {
      names(ex) &lt;- name
      return(ex)
    }
  } else return(cat(&quot;You should choose proper values for both dx and dt !&quot;))
}</code></pre>
<p>And you can call this function with the specific paremeters:<br />
<strong>This is what the question requires:</strong></p>
<pre class="r"><code># This is what the question requires.
knitr::kable(calex(1,0.2,20),&quot;html&quot;,align = &quot;c&quot;,table.attr = &quot;class=\&quot;table table-bordered\&quot;&quot;) %&gt;%
  kable_styling(bootstrap_options = c(&quot;striped&quot;,&quot;hover&quot;,&quot;responsive&quot;)) %&gt;%
  add_header_above(c(&quot;&quot;,&quot;x&quot; = length(calex(1,0.2,20))-1))</code></pre>
<pre><code>## Warning: `as.tibble()` is deprecated, use `as_tibble()` (but mind the new semantics).
## This warning is displayed once per session.</code></pre>
<table class="table table-bordered table table-striped table-hover table-responsive" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="border-bottom:hidden" colspan=" 1">
</th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="10">
<div style="border-bottom: 1px solid #ddd; padding-bottom: 5px;">
x
</div>
</th>
</tr>
<tr>
<th style="text-align:center;">
t
</th>
<th style="text-align:center;">
-1
</th>
<th style="text-align:center;">
0
</th>
<th style="text-align:center;">
1
</th>
<th style="text-align:center;">
2
</th>
<th style="text-align:center;">
3
</th>
<th style="text-align:center;">
4
</th>
<th style="text-align:center;">
5
</th>
<th style="text-align:center;">
6
</th>
<th style="text-align:center;">
7
</th>
<th style="text-align:center;">
8
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
0.0
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
0.00000
</td>
<td style="text-align:center;">
0.00000
</td>
<td style="text-align:center;">
0.00000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
</tr>
<tr>
<td style="text-align:center;">
0.2
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
11.93960
</td>
<td style="text-align:center;">
8.00000
</td>
<td style="text-align:center;">
0.00000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
</tr>
<tr>
<td style="text-align:center;">
0.4
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
16.71544
</td>
<td style="text-align:center;">
13.55186
</td>
<td style="text-align:center;">
6.35168
</td>
<td style="text-align:center;">
3.200000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
</tr>
<tr>
<td style="text-align:center;">
0.6
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
18.62578
</td>
<td style="text-align:center;">
16.71335
</td>
<td style="text-align:center;">
11.89629
</td>
<td style="text-align:center;">
7.951899
</td>
<td style="text-align:center;">
3.171008
</td>
<td style="text-align:center;">
1.280000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
</tr>
<tr>
<td style="text-align:center;">
0.8
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
19.38991
</td>
<td style="text-align:center;">
18.35425
</td>
<td style="text-align:center;">
15.50102
</td>
<td style="text-align:center;">
12.209433
</td>
<td style="text-align:center;">
7.593286
</td>
<td style="text-align:center;">
4.317385
</td>
<td style="text-align:center;">
1.520538
</td>
<td style="text-align:center;">
0.512000
</td>
</tr>
<tr>
<td style="text-align:center;">
1.0
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
19.69556
</td>
<td style="text-align:center;">
19.16112
</td>
<td style="text-align:center;">
17.57179
</td>
<td style="text-align:center;">
15.278863
</td>
<td style="text-align:center;">
11.642738
</td>
<td style="text-align:center;">
8.106452
</td>
<td style="text-align:center;">
4.495968
</td>
<td style="text-align:center;">
2.231269
</td>
</tr>
</tbody>
</table>
<p>In this function as we can see, <em>1</em> is the quantity of dx, <em>0.2</em> is the quantity of dt and <em>20</em> is the quantity of BOD. And in this table, the numeric row names means the value of x(Km). Pay attention to the <em>-1</em> column, this column is added for backward differece method.</p>
<p>You can change them as you want:</p>
<pre class="r"><code>knitr::kable(calex(1,0.2,10),table.attr = &quot;class=\&quot;table table-bordered\&quot;&quot;) %&gt;%
  kable_styling(bootstrap_options = c(&quot;striped&quot;,&quot;hover&quot;,&quot;responsive&quot;)) %&gt;%
  add_header_above(c(&quot;&quot;,&quot;x&quot; = length(calex(1,0.2,20))-1))</code></pre>
<table class="table table-bordered table table-striped table-hover table-responsive" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="border-bottom:hidden" colspan=" 1">
</th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="10">
<div style="border-bottom: 1px solid #ddd; padding-bottom: 5px;">
x
</div>
</th>
</tr>
<tr>
<th style="text-align:right;">
t
</th>
<th style="text-align:right;">
-1
</th>
<th style="text-align:right;">
0
</th>
<th style="text-align:right;">
1
</th>
<th style="text-align:right;">
2
</th>
<th style="text-align:right;">
3
</th>
<th style="text-align:right;">
4
</th>
<th style="text-align:right;">
5
</th>
<th style="text-align:right;">
6
</th>
<th style="text-align:right;">
7
</th>
<th style="text-align:right;">
8
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
0.000000
</td>
<td style="text-align:right;">
0.000000
</td>
<td style="text-align:right;">
0.000000
</td>
<td style="text-align:right;">
0.000000
</td>
<td style="text-align:right;">
0.000000
</td>
<td style="text-align:right;">
0.000000
</td>
<td style="text-align:right;">
0.0000000
</td>
<td style="text-align:right;">
0.000000
</td>
</tr>
<tr>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
5.969800
</td>
<td style="text-align:right;">
4.000000
</td>
<td style="text-align:right;">
0.000000
</td>
<td style="text-align:right;">
0.000000
</td>
<td style="text-align:right;">
0.000000
</td>
<td style="text-align:right;">
0.000000
</td>
<td style="text-align:right;">
0.0000000
</td>
<td style="text-align:right;">
0.000000
</td>
</tr>
<tr>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
8.357720
</td>
<td style="text-align:right;">
6.775931
</td>
<td style="text-align:right;">
3.175840
</td>
<td style="text-align:right;">
1.600000
</td>
<td style="text-align:right;">
0.000000
</td>
<td style="text-align:right;">
0.000000
</td>
<td style="text-align:right;">
0.0000000
</td>
<td style="text-align:right;">
0.000000
</td>
</tr>
<tr>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
9.312888
</td>
<td style="text-align:right;">
8.356676
</td>
<td style="text-align:right;">
5.948147
</td>
<td style="text-align:right;">
3.975949
</td>
<td style="text-align:right;">
1.585504
</td>
<td style="text-align:right;">
0.640000
</td>
<td style="text-align:right;">
0.0000000
</td>
<td style="text-align:right;">
0.000000
</td>
</tr>
<tr>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
9.694955
</td>
<td style="text-align:right;">
9.177123
</td>
<td style="text-align:right;">
7.750512
</td>
<td style="text-align:right;">
6.104716
</td>
<td style="text-align:right;">
3.796643
</td>
<td style="text-align:right;">
2.158692
</td>
<td style="text-align:right;">
0.7602688
</td>
<td style="text-align:right;">
0.256000
</td>
</tr>
<tr>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
9.847782
</td>
<td style="text-align:right;">
9.580561
</td>
<td style="text-align:right;">
8.785897
</td>
<td style="text-align:right;">
7.639432
</td>
<td style="text-align:right;">
5.821369
</td>
<td style="text-align:right;">
4.053226
</td>
<td style="text-align:right;">
2.2479839
</td>
<td style="text-align:right;">
1.115635
</td>
</tr>
</tbody>
</table>
<p>Sometimes you want to change the default value of, for example, x , k1 or t. You can do it because they are all parameters, which have default values perserved in the function beforehand. Just like this:</p>
<pre class="r"><code>knitr::kable(calex(0.5,0.1,10,t = 2,x = 10),align = &quot;c&quot;,
             table.attr = &quot;class=\&quot;table table-bordered\&quot;&quot;)</code></pre>
<pre><code>## You should choose proper values for both dx and dt !</code></pre>
<table class="table table-bordered">
<tbody>
<tr>
</tr>
</tbody>
</table>
<p>Error! But don’t warry! Your values of dx and dt just fail to meet the condition. Change them like this:<br />
<strong>And this is the same table as the corresponding example in our book:</strong></p>
<pre class="r"><code>knitr::kable(calex(1,0.2,10,t = 2,x = 10),&quot;html&quot;,align = &quot;c&quot;,
             table.attr = &quot;class=\&quot;table table-bordered\&quot;&quot;) %&gt;%
  kable_styling(bootstrap_options = c(&quot;striped&quot;,&quot;hover&quot;,&quot;responsive&quot;)) %&gt;%
  add_header_above(c(&quot;&quot;,&quot;x&quot; = length(calex(1,0.2,10,t = 2,x = 10))-1))</code></pre>
<table class="table table-bordered table table-striped table-hover table-responsive" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="border-bottom:hidden" colspan=" 1">
</th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="12">
<div style="border-bottom: 1px solid #ddd; padding-bottom: 5px;">
x
</div>
</th>
</tr>
<tr>
<th style="text-align:center;">
t
</th>
<th style="text-align:center;">
-1
</th>
<th style="text-align:center;">
0
</th>
<th style="text-align:center;">
1
</th>
<th style="text-align:center;">
2
</th>
<th style="text-align:center;">
3
</th>
<th style="text-align:center;">
4
</th>
<th style="text-align:center;">
5
</th>
<th style="text-align:center;">
6
</th>
<th style="text-align:center;">
7
</th>
<th style="text-align:center;">
8
</th>
<th style="text-align:center;">
9
</th>
<th style="text-align:center;">
10
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
0.0
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
</tr>
<tr>
<td style="text-align:center;">
0.2
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
5.969800
</td>
<td style="text-align:center;">
4.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
</tr>
<tr>
<td style="text-align:center;">
0.4
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
8.357720
</td>
<td style="text-align:center;">
6.775931
</td>
<td style="text-align:center;">
3.175840
</td>
<td style="text-align:center;">
1.600000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
</tr>
<tr>
<td style="text-align:center;">
0.6
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
9.312888
</td>
<td style="text-align:center;">
8.356676
</td>
<td style="text-align:center;">
5.948147
</td>
<td style="text-align:center;">
3.975949
</td>
<td style="text-align:center;">
1.585504
</td>
<td style="text-align:center;">
0.640000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
</tr>
<tr>
<td style="text-align:center;">
0.8
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
9.694955
</td>
<td style="text-align:center;">
9.177123
</td>
<td style="text-align:center;">
7.750512
</td>
<td style="text-align:center;">
6.104716
</td>
<td style="text-align:center;">
3.796643
</td>
<td style="text-align:center;">
2.158692
</td>
<td style="text-align:center;">
0.7602688
</td>
<td style="text-align:center;">
0.256000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
</tr>
<tr>
<td style="text-align:center;">
1.0
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
9.847782
</td>
<td style="text-align:center;">
9.580561
</td>
<td style="text-align:center;">
8.785897
</td>
<td style="text-align:center;">
7.639432
</td>
<td style="text-align:center;">
5.821369
</td>
<td style="text-align:center;">
4.053226
</td>
<td style="text-align:center;">
2.2479839
</td>
<td style="text-align:center;">
1.115635
</td>
<td style="text-align:center;">
0.3545344
</td>
<td style="text-align:center;">
0.1024000
</td>
</tr>
<tr>
<td style="text-align:center;">
1.2
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
9.908913
</td>
<td style="text-align:center;">
9.772041
</td>
<td style="text-align:center;">
9.340651
</td>
<td style="text-align:center;">
8.618643
</td>
<td style="text-align:center;">
7.347721
</td>
<td style="text-align:center;">
5.823756
</td>
<td style="text-align:center;">
4.0261456
</td>
<td style="text-align:center;">
2.510352
</td>
<td style="text-align:center;">
1.2607650
</td>
<td style="text-align:center;">
0.5570501
</td>
</tr>
<tr>
<td style="text-align:center;">
1.4
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
9.933365
</td>
<td style="text-align:center;">
9.860674
</td>
<td style="text-align:center;">
9.624722
</td>
<td style="text-align:center;">
9.196195
</td>
<td style="text-align:center;">
8.373049
</td>
<td style="text-align:center;">
7.224314
</td>
<td style="text-align:center;">
5.6967104
</td>
<td style="text-align:center;">
4.126714
</td>
<td style="text-align:center;">
2.6092534
</td>
<td style="text-align:center;">
1.4753064
</td>
</tr>
<tr>
<td style="text-align:center;">
1.6
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
9.943146
</td>
<td style="text-align:center;">
9.900944
</td>
<td style="text-align:center;">
9.765590
</td>
<td style="text-align:center;">
9.518625
</td>
<td style="text-align:center;">
9.010575
</td>
<td style="text-align:center;">
8.217527
</td>
<td style="text-align:center;">
7.0509492
</td>
<td style="text-align:center;">
5.662549
</td>
<td style="text-align:center;">
4.1352656
</td>
<td style="text-align:center;">
2.7547787
</td>
</tr>
<tr>
<td style="text-align:center;">
1.8
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
9.947058
</td>
<td style="text-align:center;">
9.918978
</td>
<td style="text-align:center;">
9.833782
</td>
<td style="text-align:center;">
9.691454
</td>
<td style="text-align:center;">
9.385445
</td>
<td style="text-align:center;">
8.869364
</td>
<td style="text-align:center;">
8.0432980
</td>
<td style="text-align:center;">
6.940926
</td>
<td style="text-align:center;">
5.5898948
</td>
<td style="text-align:center;">
4.1814957
</td>
</tr>
<tr>
<td style="text-align:center;">
2.0
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
9.948623
</td>
<td style="text-align:center;">
9.926963
</td>
<td style="text-align:center;">
9.866177
</td>
<td style="text-align:center;">
9.781231
</td>
<td style="text-align:center;">
9.596713
</td>
<td style="text-align:center;">
9.273072
</td>
<td style="text-align:center;">
8.7185845
</td>
<td style="text-align:center;">
7.908485
</td>
<td style="text-align:center;">
6.8205008
</td>
<td style="text-align:center;">
5.5500663
</td>
</tr>
</tbody>
</table>
<p>Besides, the visualization of the result can be shown here:</p>
<pre class="r"><code>calex(1,0.2,10,t = 2,x = 10,plot = TRUE)[[2]]</code></pre>
<p><div id="plot_id106138960-container" class="ggvis-output-container">
<div id="plot_id106138960" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id106138960_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id106138960" data-renderer="svg">SVG</a>
 | 
<a id="plot_id106138960_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id106138960" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id106138960_download" class="ggvis-download" data-plot-id="plot_id106138960">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id106138960_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "t": "number"
        }
      },
      "values": "\"x\",\"t\",\"factor(BOD * 25)\"\n\"0\",0.2,\"250\"\n\"0\",0.4,\"250\"\n\"0\",0.6,\"250\"\n\"0\",0.8,\"250\"\n\"0\",1,\"250\"\n\"0\",1.2,\"250\"\n\"0\",1.4,\"250\"\n\"0\",1.6,\"250\"\n\"0\",1.8,\"250\"\n\"0\",2,\"250\"\n\"1\",0.2,\"149.245\"\n\"1\",0.4,\"208.943\"\n\"1\",0.6,\"232.8222\"\n\"1\",0.8,\"242.37388\"\n\"1\",1,\"246.194552\"\n\"1\",1.2,\"247.7228208\"\n\"1\",1.4,\"248.33412832\"\n\"1\",1.6,\"248.578651328\"\n\"1\",1.8,\"248.6764605312\"\n\"1\",2,\"248.71558421248\"\n\"2\",0.2,\"100\"\n\"2\",0.4,\"169.3982801\"\n\"2\",0.6,\"208.91690418\"\n\"2\",0.8,\"229.428078628\"\n\"2\",1,\"239.5140383336\"\n\"2\",1.2,\"244.3010181864\"\n\"2\",1.4,\"246.516848515744\"\n\"2\",1.6,\"247.523596002771\"\n\"2\",1.8,\"247.974461139698\"\n\"2\",2,\"248.174073651315\"\n\"3\",0.2,\"0\"\n\"3\",0.4,\"79.396\"\n\"3\",0.6,\"148.703673214098\"\n\"3\",0.8,\"193.762801071016\"\n\"3\",1,\"219.64741535655\"\n\"3\",1.2,\"233.516262213572\"\n\"3\",1.4,\"240.618047767786\"\n\"3\",1.6,\"244.139759255746\"\n\"3\",1.8,\"245.844562174124\"\n\"3\",2,\"246.654418437427\"\n\"4\",0.2,\"0\"\n\"4\",0.4,\"40\"\n\"4\",0.6,\"99.39873612\"\n\"4\",0.8,\"152.617905669713\"\n\"4\",1,\"190.985790274054\"\n\"4\",1.2,\"215.466079319995\"\n\"4\",1.4,\"229.904872333387\"\n\"4\",1.6,\"237.965631388951\"\n\"4\",1.8,\"242.286340734886\"\n\"4\",2,\"244.530782606892\"\n\"5\",0.2,\"0\"\n\"5\",0.4,\"0\"\n\"5\",0.6,\"39.6376\"\n\"5\",0.8,\"94.9160723265568\"\n\"5\",1,\"145.534224417849\"\n\"5\",1.2,\"183.693036877943\"\n\"5\",1.4,\"209.326227941059\"\n\"5\",1.6,\"225.264372035768\"\n\"5\",1.8,\"234.636122587601\"\n\"5\",2,\"239.917837302648\"\n\"6\",0.2,\"0\"\n\"6\",0.4,\"0\"\n\"6\",0.6,\"16\"\n\"6\",0.8,\"53.967308896\"\n\"6\",1,\"101.33065375317\"\n\"6\",1.2,\"145.593909136718\"\n\"6\",1.4,\"180.607849786902\"\n\"6\",1.6,\"205.438169227945\"\n\"6\",1.8,\"221.734096250364\"\n\"6\",2,\"231.826798221406\"\n\"7\",0.2,\"0\"\n\"7\",0.4,\"0\"\n\"7\",0.6,\"0\"\n\"7\",0.8,\"19.00672\"\n\"7\",1,\"56.1995974369568\"\n\"7\",1.2,\"100.653640918222\"\n\"7\",1.4,\"142.417759340216\"\n\"7\",1.6,\"176.273729163534\"\n\"7\",1.8,\"201.082451054242\"\n\"7\",2,\"217.964611736134\"\n\"8\",0.2,\"0\"\n\"8\",0.4,\"0\"\n\"8\",0.6,\"0\"\n\"8\",0.8,\"6.4\"\n\"8\",1,\"27.890867264\"\n\"8\",1.2,\"62.7588051099999\"\n\"8\",1.4,\"103.167839886758\"\n\"8\",1.6,\"141.5637261043\"\n\"8\",1.8,\"173.523157303531\"\n\"8\",2,\"197.712122630223\"\n\"9\",0.2,\"0\"\n\"9\",0.4,\"0\"\n\"9\",0.6,\"0\"\n\"9\",0.8,\"0\"\n\"9\",1,\"8.86336\"\n\"9\",1.2,\"31.5191260084454\"\n\"9\",1.4,\"65.2313362012347\"\n\"9\",1.6,\"103.381639317474\"\n\"9\",1.8,\"139.747370160428\"\n\"9\",2,\"170.512520011518\"\n\"10\",0.2,\"0\"\n\"10\",0.4,\"0\"\n\"10\",0.6,\"0\"\n\"10\",0.8,\"0\"\n\"10\",1,\"2.56\"\n\"10\",1.2,\"13.9262515584\"\n\"10\",1.4,\"36.8826601085035\"\n\"10\",1.6,\"68.8694686030239\"\n\"10\",1.8,\"104.537393195686\"\n\"10\",2,\"138.751657173888\""
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {}
      },
      "values": "\"domain\"\n\"-1\"\n\"0\"\n\"1\"\n\"2\"\n\"3\"\n\"4\"\n\"5\"\n\"6\"\n\"7\"\n\"8\"\n\"9\"\n\"10\""
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0.11\n2.09"
    }
  ],
  "scales": [
    {
      "name": "x",
      "type": "ordinal",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "points": true,
      "sort": false,
      "range": "width",
      "padding": 0.5
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "fill": {
            "value": "#000000"
          },
          "x": {
            "scale": "x",
            "field": "data.x"
          },
          "y": {
            "scale": "y",
            "field": "data.t"
          },
          "size": {
            "field": "data.factor(BOD * 25)"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "x"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "t"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id106138960").parseSpec(plot_id106138960_spec);
</script> As you can see, the size of each point means the quantity of the BOD value. And I ignore the condition where x = <em>-1</em> and t = <em>0</em>.</p>
</div>
<div id="implicit-difference-method" class="section level1">
<h1>Implicit Difference Method</h1>
<p>Next comes the implicit differece method based on <code>calim</code> function. You can call this function with different parameters to solve the specific problems. As you can see, the method is more complex and difficult than the last method.</p>
<pre class="r"><code>calim &lt;- function(dx,dt,BOD,x = 8,u = 5,E = 2, k1 = 0.0151,t = 1,plot = FALSE) {
  col &lt;- x/dx+2; row &lt;- t/dt+1; name &lt;- c(&#39;t&#39;,seq(0,x,dx))
  alpha &lt;- -E/dx^2; beta &lt;- 1/dt+2*E/dx^2+k1/2; gamma &lt;- alpha
  d2 &lt;- 1/dt-u/dx; d1 &lt;- u/dx-k1/2
  im &lt;- rep(0,row*col);attr(im,&quot;dim&quot;) &lt;- c(row,col); im &lt;- as.tibble(im)
  im[,1] &lt;- seq(0.0,t,dt); im[,2] &lt;- BOD
  delta &lt;- rep(0,(row-1)*(col-1-1)); attr(delta,&#39;dim&#39;) &lt;- c(row-1,col-1-1); delta &lt;- as.tibble(delta)
  g &lt;- delta[1:(row-1),1:(col-1-1)]; omega &lt;- delta[1:(row-1),1:(col-1-1-1)]
  if(dt*u/dx &gt; 1 | dt*u/dx &lt;= 0.5) {
    return(cat(&quot;You should choose proper values for both dx and dt !&quot;))
  } else {
    for(j in 1:(t/dt)) {
      delta[j,1] &lt;- im[j,2]*d1+im[j,3]*d2
      delta[j,1] &lt;- delta[j,1]-alpha*im[j,2]
      delta[j,2:(x/dx)] &lt;- im[j,3:(x/dx+1)]*d1+im[j,4:(x/dx+2)]*d2
      for(i in 1:(x/dx-2)) {
        omega[j,1] &lt;- gamma/beta; g[j,1] &lt;- delta[j,1]/beta
        g[j,i+1] &lt;- (delta[j,i+1]-alpha*g[j,i])/(beta-alpha*omega[j,i])
        omega[j,i+1] &lt;- gamma/(beta-alpha*omega[j,i])
      }
      alphap &lt;- alpha - gamma; betap &lt;- beta + 2*gamma
      g[j,x/dx] &lt;- (delta[j,x/dx]-alphap*g[j,x/dx-1])/(betap-alphap*omega[j,x/dx-1])
      im[j+1,x/dx+2] &lt;- g[j,x/dx]
      for(k in (x/dx+1):3) im[j+1,k] &lt;- -im[j+1,k+1]*omega[j,k-2]+g[j,k-2]
    }
    if (plot) {
      names(im) &lt;- name
      pim &lt;- im %&gt;%
        dplyr::filter(t != 0) %&gt;%
        melt(id = &quot;t&quot;,variable.name = &quot;x&quot;,value.name = &quot;BOD&quot;) %&gt;%
        dplyr::filter(x != 0) %&gt;%
        ggvis(~x,~t) %&gt;%
        layer_points(size:=~factor(BOD*25))
      return(list(im,pim))
    } else {
      names(im) &lt;- name
      return(im)
    }
  }
}</code></pre>
<p>And you can call this function with the specific paremeters:<br />
<strong>This is what the question requires:</strong></p>
<pre class="r"><code>knitr::kable(calim(dx = 0.5,dt = 0.1, BOD = 20),&quot;html&quot;,align = &quot;c&quot;,
             table.attr = &quot;class=\&quot;table table-bordered\&quot;&quot;) %&gt;%
  kable_styling(bootstrap_options = c(&quot;striped&quot;,&quot;hover&quot;,&quot;responsive&quot;)) %&gt;%
  add_header_above(c(&quot;&quot;,&quot;x&quot; = length(calim(dx = 0.5,dt = 0.1, BOD = 20))-1)) %&gt;%
  scroll_box(width = &quot;100%&quot;)</code></pre>
<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">
<table class="table table-bordered table table-striped table-hover table-responsive" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="border-bottom:hidden" colspan=" 1">
</th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="17">
<div style="border-bottom: 1px solid #ddd; padding-bottom: 5px;">
x
</div>
</th>
</tr>
<tr>
<th style="text-align:center;">
t
</th>
<th style="text-align:center;">
0
</th>
<th style="text-align:center;">
0.5
</th>
<th style="text-align:center;">
1
</th>
<th style="text-align:center;">
1.5
</th>
<th style="text-align:center;">
2
</th>
<th style="text-align:center;">
2.5
</th>
<th style="text-align:center;">
3
</th>
<th style="text-align:center;">
3.5
</th>
<th style="text-align:center;">
4
</th>
<th style="text-align:center;">
4.5
</th>
<th style="text-align:center;">
5
</th>
<th style="text-align:center;">
5.5
</th>
<th style="text-align:center;">
6
</th>
<th style="text-align:center;">
6.5
</th>
<th style="text-align:center;">
7
</th>
<th style="text-align:center;">
7.5
</th>
<th style="text-align:center;">
8
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
0.0
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
0.00000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
</tr>
<tr>
<td style="text-align:center;">
0.1
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
15.47371
</td>
<td style="text-align:center;">
5.323023
</td>
<td style="text-align:center;">
1.831144
</td>
<td style="text-align:center;">
0.6299215
</td>
<td style="text-align:center;">
0.2166958
</td>
<td style="text-align:center;">
0.0745443
</td>
<td style="text-align:center;">
0.0256436
</td>
<td style="text-align:center;">
0.0088215
</td>
<td style="text-align:center;">
0.0030346
</td>
<td style="text-align:center;">
0.0010439
</td>
<td style="text-align:center;">
0.0003591
</td>
<td style="text-align:center;">
0.0001235
</td>
<td style="text-align:center;">
0.0000424
</td>
<td style="text-align:center;">
0.0000144
</td>
<td style="text-align:center;">
0.0000044
</td>
<td style="text-align:center;">
0.0000000
</td>
</tr>
<tr>
<td style="text-align:center;">
0.2
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
18.06790
</td>
<td style="text-align:center;">
13.756609
</td>
<td style="text-align:center;">
7.326530
</td>
<td style="text-align:center;">
3.4127739
</td>
<td style="text-align:center;">
1.4810040
</td>
<td style="text-align:center;">
0.6150795
</td>
<td style="text-align:center;">
0.2479195
</td>
<td style="text-align:center;">
0.0977829
</td>
<td style="text-align:center;">
0.0379369
</td>
<td style="text-align:center;">
0.0145294
</td>
<td style="text-align:center;">
0.0055068
</td>
<td style="text-align:center;">
0.0020689
</td>
<td style="text-align:center;">
0.0007707
</td>
<td style="text-align:center;">
0.0002822
</td>
<td style="text-align:center;">
0.0000937
</td>
<td style="text-align:center;">
0.0000044
</td>
</tr>
<tr>
<td style="text-align:center;">
0.3
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
18.99612
</td>
<td style="text-align:center;">
16.774201
</td>
<td style="text-align:center;">
12.968034
</td>
<td style="text-align:center;">
8.2013711
</td>
<td style="text-align:center;">
4.5429130
</td>
<td style="text-align:center;">
2.3046370
</td>
<td style="text-align:center;">
1.0994749
</td>
<td style="text-align:center;">
0.5014252
</td>
<td style="text-align:center;">
0.2209647
</td>
<td style="text-align:center;">
0.0947823
</td>
<td style="text-align:center;">
0.0397817
</td>
<td style="text-align:center;">
0.0163979
</td>
<td style="text-align:center;">
0.0066488
</td>
<td style="text-align:center;">
0.0026326
</td>
<td style="text-align:center;">
0.0009470
</td>
<td style="text-align:center;">
0.0000936
</td>
</tr>
<tr>
<td style="text-align:center;">
0.4
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
19.42205
</td>
<td style="text-align:center;">
18.158863
</td>
<td style="text-align:center;">
15.884167
</td>
<td style="text-align:center;">
12.5277515
</td>
<td style="text-align:center;">
8.6450437
</td>
<td style="text-align:center;">
5.3328253
</td>
<td style="text-align:center;">
3.0173174
</td>
<td style="text-align:center;">
1.5976826
</td>
<td style="text-align:center;">
0.8033530
</td>
<td style="text-align:center;">
0.3876644
</td>
<td style="text-align:center;">
0.1809250
</td>
<td style="text-align:center;">
0.0821242
</td>
<td style="text-align:center;">
0.0363666
</td>
<td style="text-align:center;">
0.0156195
</td>
<td style="text-align:center;">
0.0061069
</td>
<td style="text-align:center;">
0.0009456
</td>
</tr>
<tr>
<td style="text-align:center;">
0.5
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
19.64369
</td>
<td style="text-align:center;">
18.879391
</td>
<td style="text-align:center;">
17.472921
</td>
<td style="text-align:center;">
15.2426522
</td>
<td style="text-align:center;">
12.2398650
</td>
<td style="text-align:center;">
8.9005941
</td>
<td style="text-align:center;">
5.8973198
</td>
<td style="text-align:center;">
3.6102622
</td>
<td style="text-align:center;">
2.0706404
</td>
<td style="text-align:center;">
1.1256777
</td>
<td style="text-align:center;">
0.5854414
</td>
<td style="text-align:center;">
0.2933448
</td>
<td style="text-align:center;">
0.1422205
</td>
<td style="text-align:center;">
0.0664284
</td>
<td style="text-align:center;">
0.0283105
</td>
<td style="text-align:center;">
0.0060977
</td>
</tr>
<tr>
<td style="text-align:center;">
0.6
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
19.76811
</td>
<td style="text-align:center;">
19.283897
</td>
<td style="text-align:center;">
18.386685
</td>
<td style="text-align:center;">
16.9087607
</td>
<td style="text-align:center;">
14.7580832
</td>
<td style="text-align:center;">
12.0300076
</td>
<td style="text-align:center;">
9.0625149
</td>
<td style="text-align:center;">
6.3143759
</td>
<td style="text-align:center;">
4.0990819
</td>
<td style="text-align:center;">
2.5020880
</td>
<td style="text-align:center;">
1.4487193
</td>
<td style="text-align:center;">
0.8015823
</td>
<td style="text-align:center;">
0.4259303
</td>
<td style="text-align:center;">
0.2166890
</td>
<td style="text-align:center;">
0.1008721
</td>
<td style="text-align:center;">
0.0282678
</td>
</tr>
<tr>
<td style="text-align:center;">
0.7
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
19.84160
</td>
<td style="text-align:center;">
19.522808
</td>
<td style="text-align:center;">
18.934465
</td>
<td style="text-align:center;">
17.9453990
</td>
<td style="text-align:center;">
16.4390139
</td>
<td style="text-align:center;">
14.3769174
</td>
<td style="text-align:center;">
11.8658597
</td>
<td style="text-align:center;">
9.1721689
</td>
<td style="text-align:center;">
6.6327546
</td>
<td style="text-align:center;">
4.5035325
</td>
<td style="text-align:center;">
2.8879926
</td>
<td style="text-align:center;">
1.7599202
</td>
<td style="text-align:center;">
1.0238769
</td>
<td style="text-align:center;">
0.5674248
</td>
<td style="text-align:center;">
0.2887781
</td>
<td style="text-align:center;">
0.1007199
</td>
</tr>
<tr>
<td style="text-align:center;">
0.8
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
19.88661
</td>
<td style="text-align:center;">
19.669128
</td>
<td style="text-align:center;">
19.273340
</td>
<td style="text-align:center;">
18.6023308
</td>
<td style="text-align:center;">
17.5515793
</td>
<td style="text-align:center;">
16.0420534
</td>
<td style="text-align:center;">
14.0669809
</td>
<td style="text-align:center;">
11.7313318
</td>
<td style="text-align:center;">
9.2497928
</td>
<td style="text-align:center;">
6.8826694
</td>
<td style="text-align:center;">
4.8406946
</td>
<td style="text-align:center;">
3.2289910
</td>
<td style="text-align:center;">
2.0493083
</td>
<td style="text-align:center;">
1.2349557
</td>
<td style="text-align:center;">
0.6865832
</td>
<td style="text-align:center;">
0.2883424
</td>
</tr>
<tr>
<td style="text-align:center;">
0.9
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
19.91494
</td>
<td style="text-align:center;">
19.761212
</td>
<td style="text-align:center;">
19.488158
</td>
<td style="text-align:center;">
19.0258468
</td>
<td style="text-align:center;">
18.2903135
</td>
<td style="text-align:center;">
17.1995760
</td>
<td style="text-align:center;">
15.7016309
</td>
<td style="text-align:center;">
13.8081156
</td>
<td style="text-align:center;">
11.6173257
</td>
<td style="text-align:center;">
9.3060635
</td>
<td style="text-align:center;">
7.0826517
</td>
<td style="text-align:center;">
5.1223975
</td>
<td style="text-align:center;">
3.5236746
</td>
<td style="text-align:center;">
2.2996790
</td>
<td style="text-align:center;">
1.3927511
</td>
<td style="text-align:center;">
0.6855473
</td>
</tr>
<tr>
<td style="text-align:center;">
1.0
</td>
<td style="text-align:center;">
20
</td>
<td style="text-align:center;">
19.93314
</td>
<td style="text-align:center;">
19.820404
</td>
<td style="text-align:center;">
19.626999
</td>
<td style="text-align:center;">
19.3030010
</td>
<td style="text-align:center;">
18.7841651
</td>
<td style="text-align:center;">
17.9989104
</td>
<td style="text-align:center;">
16.8836498
</td>
<td style="text-align:center;">
15.4056475
</td>
<td style="text-align:center;">
13.5870236
</td>
<td style="text-align:center;">
11.5178887
</td>
<td style="text-align:center;">
9.3462915
</td>
<td style="text-align:center;">
7.2425826
</td>
<td style="text-align:center;">
5.3523068
</td>
<td style="text-align:center;">
3.7593031
</td>
<td style="text-align:center;">
2.4677084
</td>
<td style="text-align:center;">
1.3906496
</td>
</tr>
</tbody>
</table>
</div>
<p>Similarly, you can change the parameters:<br />
<strong>And this is the same table as the corresponding example in our book:</strong></p>
<pre class="r"><code>knitr::kable(calim(dx = 0.5,dt = 0.1, BOD = 10, x = 8),&quot;html&quot;,align = &quot;c&quot;,
             table.attr = &quot;class=\&quot;table table-bordered\&quot;&quot;)%&gt;%
  kable_styling(bootstrap_options = c(&quot;striped&quot;,&quot;hover&quot;,&quot;responsive&quot;)) %&gt;%
  add_header_above(c(&quot;&quot;,&quot;x&quot; = length(calim(dx = 0.5,dt = 0.1, BOD = 10, x = 8))-1)) %&gt;%
  scroll_box(width = &quot;100%&quot;)</code></pre>
<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">
<table class="table table-bordered table table-striped table-hover table-responsive" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="border-bottom:hidden" colspan=" 1">
</th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="17">
<div style="border-bottom: 1px solid #ddd; padding-bottom: 5px;">
x
</div>
</th>
</tr>
<tr>
<th style="text-align:center;">
t
</th>
<th style="text-align:center;">
0
</th>
<th style="text-align:center;">
0.5
</th>
<th style="text-align:center;">
1
</th>
<th style="text-align:center;">
1.5
</th>
<th style="text-align:center;">
2
</th>
<th style="text-align:center;">
2.5
</th>
<th style="text-align:center;">
3
</th>
<th style="text-align:center;">
3.5
</th>
<th style="text-align:center;">
4
</th>
<th style="text-align:center;">
4.5
</th>
<th style="text-align:center;">
5
</th>
<th style="text-align:center;">
5.5
</th>
<th style="text-align:center;">
6
</th>
<th style="text-align:center;">
6.5
</th>
<th style="text-align:center;">
7
</th>
<th style="text-align:center;">
7.5
</th>
<th style="text-align:center;">
8
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
0.0
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
<td style="text-align:center;">
0.0000000
</td>
</tr>
<tr>
<td style="text-align:center;">
0.1
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
7.736853
</td>
<td style="text-align:center;">
2.661512
</td>
<td style="text-align:center;">
0.9155718
</td>
<td style="text-align:center;">
0.3149608
</td>
<td style="text-align:center;">
0.1083479
</td>
<td style="text-align:center;">
0.0372722
</td>
<td style="text-align:center;">
0.0128218
</td>
<td style="text-align:center;">
0.0044108
</td>
<td style="text-align:center;">
0.0015173
</td>
<td style="text-align:center;">
0.0005220
</td>
<td style="text-align:center;">
0.0001796
</td>
<td style="text-align:center;">
0.0000618
</td>
<td style="text-align:center;">
0.0000212
</td>
<td style="text-align:center;">
0.0000072
</td>
<td style="text-align:center;">
0.0000022
</td>
<td style="text-align:center;">
0.0000000
</td>
</tr>
<tr>
<td style="text-align:center;">
0.2
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
9.033951
</td>
<td style="text-align:center;">
6.878304
</td>
<td style="text-align:center;">
3.6632653
</td>
<td style="text-align:center;">
1.7063870
</td>
<td style="text-align:center;">
0.7405020
</td>
<td style="text-align:center;">
0.3075397
</td>
<td style="text-align:center;">
0.1239598
</td>
<td style="text-align:center;">
0.0488915
</td>
<td style="text-align:center;">
0.0189685
</td>
<td style="text-align:center;">
0.0072647
</td>
<td style="text-align:center;">
0.0027534
</td>
<td style="text-align:center;">
0.0010345
</td>
<td style="text-align:center;">
0.0003853
</td>
<td style="text-align:center;">
0.0001411
</td>
<td style="text-align:center;">
0.0000469
</td>
<td style="text-align:center;">
0.0000022
</td>
</tr>
<tr>
<td style="text-align:center;">
0.3
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
9.498061
</td>
<td style="text-align:center;">
8.387100
</td>
<td style="text-align:center;">
6.4840172
</td>
<td style="text-align:center;">
4.1006856
</td>
<td style="text-align:center;">
2.2714565
</td>
<td style="text-align:center;">
1.1523185
</td>
<td style="text-align:center;">
0.5497374
</td>
<td style="text-align:center;">
0.2507126
</td>
<td style="text-align:center;">
0.1104823
</td>
<td style="text-align:center;">
0.0473911
</td>
<td style="text-align:center;">
0.0198909
</td>
<td style="text-align:center;">
0.0081990
</td>
<td style="text-align:center;">
0.0033244
</td>
<td style="text-align:center;">
0.0013163
</td>
<td style="text-align:center;">
0.0004735
</td>
<td style="text-align:center;">
0.0000468
</td>
</tr>
<tr>
<td style="text-align:center;">
0.4
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
9.711024
</td>
<td style="text-align:center;">
9.079431
</td>
<td style="text-align:center;">
7.9420837
</td>
<td style="text-align:center;">
6.2638758
</td>
<td style="text-align:center;">
4.3225218
</td>
<td style="text-align:center;">
2.6664126
</td>
<td style="text-align:center;">
1.5086587
</td>
<td style="text-align:center;">
0.7988413
</td>
<td style="text-align:center;">
0.4016765
</td>
<td style="text-align:center;">
0.1938322
</td>
<td style="text-align:center;">
0.0904625
</td>
<td style="text-align:center;">
0.0410621
</td>
<td style="text-align:center;">
0.0181833
</td>
<td style="text-align:center;">
0.0078098
</td>
<td style="text-align:center;">
0.0030535
</td>
<td style="text-align:center;">
0.0004728
</td>
</tr>
<tr>
<td style="text-align:center;">
0.5
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
9.821843
</td>
<td style="text-align:center;">
9.439695
</td>
<td style="text-align:center;">
8.7364606
</td>
<td style="text-align:center;">
7.6213261
</td>
<td style="text-align:center;">
6.1199325
</td>
<td style="text-align:center;">
4.4502970
</td>
<td style="text-align:center;">
2.9486599
</td>
<td style="text-align:center;">
1.8051311
</td>
<td style="text-align:center;">
1.0353202
</td>
<td style="text-align:center;">
0.5628388
</td>
<td style="text-align:center;">
0.2927207
</td>
<td style="text-align:center;">
0.1466724
</td>
<td style="text-align:center;">
0.0711103
</td>
<td style="text-align:center;">
0.0332142
</td>
<td style="text-align:center;">
0.0141552
</td>
<td style="text-align:center;">
0.0030489
</td>
</tr>
<tr>
<td style="text-align:center;">
0.6
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
9.884056
</td>
<td style="text-align:center;">
9.641949
</td>
<td style="text-align:center;">
9.1933426
</td>
<td style="text-align:center;">
8.4543803
</td>
<td style="text-align:center;">
7.3790416
</td>
<td style="text-align:center;">
6.0150038
</td>
<td style="text-align:center;">
4.5312574
</td>
<td style="text-align:center;">
3.1571880
</td>
<td style="text-align:center;">
2.0495409
</td>
<td style="text-align:center;">
1.2510440
</td>
<td style="text-align:center;">
0.7243597
</td>
<td style="text-align:center;">
0.4007911
</td>
<td style="text-align:center;">
0.2129652
</td>
<td style="text-align:center;">
0.1083445
</td>
<td style="text-align:center;">
0.0504361
</td>
<td style="text-align:center;">
0.0141339
</td>
</tr>
<tr>
<td style="text-align:center;">
0.7
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
9.920801
</td>
<td style="text-align:center;">
9.761404
</td>
<td style="text-align:center;">
9.4672324
</td>
<td style="text-align:center;">
8.9726995
</td>
<td style="text-align:center;">
8.2195070
</td>
<td style="text-align:center;">
7.1884587
</td>
<td style="text-align:center;">
5.9329298
</td>
<td style="text-align:center;">
4.5860844
</td>
<td style="text-align:center;">
3.3163773
</td>
<td style="text-align:center;">
2.2517663
</td>
<td style="text-align:center;">
1.4439963
</td>
<td style="text-align:center;">
0.8799601
</td>
<td style="text-align:center;">
0.5119385
</td>
<td style="text-align:center;">
0.2837124
</td>
<td style="text-align:center;">
0.1443891
</td>
<td style="text-align:center;">
0.0503600
</td>
</tr>
<tr>
<td style="text-align:center;">
0.8
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
9.943305
</td>
<td style="text-align:center;">
9.834564
</td>
<td style="text-align:center;">
9.6366700
</td>
<td style="text-align:center;">
9.3011654
</td>
<td style="text-align:center;">
8.7757896
</td>
<td style="text-align:center;">
8.0210267
</td>
<td style="text-align:center;">
7.0334905
</td>
<td style="text-align:center;">
5.8656659
</td>
<td style="text-align:center;">
4.6248964
</td>
<td style="text-align:center;">
3.4413347
</td>
<td style="text-align:center;">
2.4203473
</td>
<td style="text-align:center;">
1.6144955
</td>
<td style="text-align:center;">
1.0246541
</td>
<td style="text-align:center;">
0.6174778
</td>
<td style="text-align:center;">
0.3432916
</td>
<td style="text-align:center;">
0.1441712
</td>
</tr>
<tr>
<td style="text-align:center;">
0.9
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
9.957468
</td>
<td style="text-align:center;">
9.880606
</td>
<td style="text-align:center;">
9.7440791
</td>
<td style="text-align:center;">
9.5129234
</td>
<td style="text-align:center;">
9.1451567
</td>
<td style="text-align:center;">
8.5997880
</td>
<td style="text-align:center;">
7.8508154
</td>
<td style="text-align:center;">
6.9040578
</td>
<td style="text-align:center;">
5.8086629
</td>
<td style="text-align:center;">
4.6530317
</td>
<td style="text-align:center;">
3.5413258
</td>
<td style="text-align:center;">
2.5611987
</td>
<td style="text-align:center;">
1.7618373
</td>
<td style="text-align:center;">
1.1498395
</td>
<td style="text-align:center;">
0.6963755
</td>
<td style="text-align:center;">
0.3427736
</td>
</tr>
<tr>
<td style="text-align:center;">
1.0
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
9.966572
</td>
<td style="text-align:center;">
9.910202
</td>
<td style="text-align:center;">
9.8134997
</td>
<td style="text-align:center;">
9.6515005
</td>
<td style="text-align:center;">
9.3920826
</td>
<td style="text-align:center;">
8.9994552
</td>
<td style="text-align:center;">
8.4418249
</td>
<td style="text-align:center;">
7.7028238
</td>
<td style="text-align:center;">
6.7935118
</td>
<td style="text-align:center;">
5.7589444
</td>
<td style="text-align:center;">
4.6731458
</td>
<td style="text-align:center;">
3.6212913
</td>
<td style="text-align:center;">
2.6761534
</td>
<td style="text-align:center;">
1.8796515
</td>
<td style="text-align:center;">
1.2338542
</td>
<td style="text-align:center;">
0.6953248
</td>
</tr>
</tbody>
</table>
</div>
<p>Sometimes your values are not suitable:</p>
<pre class="r"><code>knitr::kable(calim(dx = 1,dt = 0.1, BOD = 20),&quot;html&quot;,align = &quot;c&quot;,
             table.attr = &quot;class=\&quot;table table-bordered\&quot;&quot;)</code></pre>
<pre><code>## You should choose proper values for both dx and dt !</code></pre>
<table class="table table-bordered">
<tbody>
<tr>
</tr>
</tbody>
</table>
<p>And you can modify them until they are proper.</p>
<p>The visualization of the result can be available in the same way:</p>
<pre class="r"><code>calim(dx = 0.5,dt = 0.1, BOD = 20,plot = TRUE)[[2]]</code></pre>
<p><div id="plot_id947932444-container" class="ggvis-output-container">
<div id="plot_id947932444" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id947932444_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id947932444" data-renderer="svg">SVG</a>
 | 
<a id="plot_id947932444_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id947932444" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id947932444_download" class="ggvis-download" data-plot-id="plot_id947932444">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id947932444_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "t": "number"
        }
      },
      "values": "\"x\",\"t\",\"factor(BOD * 25)\"\n\"0.5\",0.1,\"386.842654982983\"\n\"0.5\",0.2,\"451.697557631175\"\n\"0.5\",0.3,\"474.903063154743\"\n\"0.5\",0.4,\"485.55121756595\"\n\"0.5\",0.5,\"491.092132161898\"\n\"0.5\",0.6,\"494.20281734951\"\n\"0.5\",0.7,\"496.040060644096\"\n\"0.5\",0.8,\"497.165268379304\"\n\"0.5\",0.9,\"497.873405071178\"\n\"0.5\",1,\"498.328593254113\"\n\"1\",0.1,\"133.075586450335\"\n\"1\",0.2,\"343.915226871332\"\n\"1\",0.3,\"419.355020018767\"\n\"1\",0.4,\"453.971571050915\"\n\"1\",0.5,\"471.984772725895\"\n\"1\",0.6,\"482.09743529478\"\n\"1\",0.7,\"488.070209900545\"\n\"1\",0.8,\"491.728196954772\"\n\"1\",0.9,\"494.030309507366\"\n\"1\",1,\"495.51010068575\"\n\"1.5\",0.1,\"45.7785910653193\"\n\"1.5\",0.2,\"183.163263722924\"\n\"1.5\",0.3,\"324.200860737438\"\n\"1.5\",0.4,\"397.104184842126\"\n\"1.5\",0.5,\"436.823031830662\"\n\"1.5\",0.6,\"459.667129810439\"\n\"1.5\",0.7,\"473.361620015256\"\n\"1.5\",0.8,\"481.833502211694\"\n\"1.5\",0.9,\"487.20395618026\"\n\"1.5\",1,\"490.674983319159\"\n\"2\",0.1,\"15.7480380572703\"\n\"2\",0.2,\"85.3193475801029\"\n\"2\",0.3,\"205.034278346423\"\n\"2\",0.4,\"313.193788037123\"\n\"2\",0.5,\"381.066304316583\"\n\"2\",0.6,\"422.719017164797\"\n\"2\",0.7,\"448.634975514011\"\n\"2\",0.8,\"465.058269485858\"\n\"2\",0.9,\"475.646169104536\"\n\"2\",1,\"482.575023837415\"\n\"2.5\",0.1,\"5.41739483172573\"\n\"2.5\",0.2,\"37.0251007603578\"\n\"2.5\",0.3,\"113.572825665109\"\n\"2.5\",0.4,\"216.126091556507\"\n\"2.5\",0.5,\"305.996624544719\"\n\"2.5\",0.6,\"368.952078995562\"\n\"2.5\",0.7,\"410.97534825413\"\n\"2.5\",0.8,\"438.789482368991\"\n\"2.5\",0.9,\"457.257837084668\"\n\"2.5\",1,\"469.604127839506\"\n\"3\",0.1,\"1.86360781221075\"\n\"3\",0.2,\"15.3769869692313\"\n\"3\",0.3,\"57.6159250785539\"\n\"3\",0.4,\"133.320631687594\"\n\"3\",0.5,\"222.514851359224\"\n\"3\",0.6,\"300.750189024302\"\n\"3\",0.7,\"359.42293391328\"\n\"3\",0.8,\"401.051335652977\"\n\"3\",0.9,\"429.989400388887\"\n\"3\",1,\"449.972760228052\"\n\"3.5\",0.1,\"0.641089337831971\"\n\"3.5\",0.2,\"6.1979880478113\"\n\"3.5\",0.3,\"27.4868723578791\"\n\"3.5\",0.4,\"75.4329350471621\"\n\"3.5\",0.5,\"147.432995317\"\n\"3.5\",0.6,\"226.562871957825\"\n\"3.5\",0.7,\"296.64649213801\"\n\"3.5\",0.8,\"351.67452336846\"\n\"3.5\",0.9,\"392.540771288579\"\n\"3.5\",1,\"422.091245422042\"\n\"4\",0.1,\"0.220537563805737\"\n\"4\",0.2,\"2.44457255198492\"\n\"4\",0.3,\"12.5356291402541\"\n\"4\",0.4,\"39.9420657292343\"\n\"4\",0.5,\"90.2565550470203\"\n\"4\",0.6,\"157.859397740982\"\n\"4\",0.7,\"229.304222372723\"\n\"4\",0.8,\"293.283296128226\"\n\"4\",0.9,\"345.202889283699\"\n\"4\",1,\"385.14118801696\"\n\"4.5\",0.1,\"0.0758658768625152\"\n\"4.5\",0.2,\"0.948423167258246\"\n\"4.5\",0.3,\"5.52411713940385\"\n\"4.5\",0.4,\"20.0838241858202\"\n\"4.5\",0.5,\"51.7660092331398\"\n\"4.5\",0.6,\"102.477046250065\"\n\"4.5\",0.7,\"165.818865196332\"\n\"4.5\",0.8,\"231.244820113438\"\n\"4.5\",0.9,\"290.433142731057\"\n\"4.5\",1,\"339.675588871448\"\n\"5\",0.1,\"0.0260981344187269\"\n\"5\",0.2,\"0.36323399353715\"\n\"5\",0.3,\"2.36955632372349\"\n\"5\",0.4,\"9.69161105844029\"\n\"5\",0.5,\"28.1419422948867\"\n\"5\",0.6,\"62.5522010991763\"\n\"5\",0.7,\"112.588313699777\"\n\"5\",0.8,\"172.06673443339\"\n\"5\",0.9,\"232.651586821129\"\n\"5\",1,\"287.94721827438\"\n\"5.5\",0.1,\"0.0089776901127047\"\n\"5.5\",0.2,\"0.137669366162036\"\n\"5.5\",0.3,\"0.994543296769308\"\n\"5.5\",0.4,\"4.52312517334261\"\n\"5.5\",0.5,\"14.6360360600829\"\n\"5.5\",0.6,\"36.217983591835\"\n\"5.5\",0.7,\"72.1998144488145\"\n\"5.5\",0.8,\"121.017364834313\"\n\"5.5\",0.9,\"177.066291529859\"\n\"5.5\",1,\"233.657288572166\"\n\"6\",0.1,\"0.00308783114260729\"\n\"6\",0.2,\"0.0517233340447313\"\n\"6\",0.3,\"0.409948301173048\"\n\"6\",0.4,\"2.05310531843168\"\n\"6\",0.5,\"7.33362029430056\"\n\"6\",0.6,\"20.0395573857346\"\n\"6\",0.7,\"43.9980040995731\"\n\"6\",0.8,\"80.7247745125238\"\n\"6\",0.9,\"128.059936902429\"\n\"6\",1,\"181.064565059901\"\n\"6.5\",0.1,\"0.00106067524140983\"\n\"6.5\",0.2,\"0.0192666434340086\"\n\"6.5\",0.3,\"0.1662187885141\"\n\"6.5\",0.4,\"0.909164208979325\"\n\"6.5\",0.5,\"3.5555132332507\"\n\"6.5\",0.6,\"10.6482579280132\"\n\"6.5\",0.7,\"25.5969232233881\"\n\"6.5\",0.8,\"51.2327068512033\"\n\"6.5\",0.9,\"88.091864063657\"\n\"6.5\",1,\"133.807669456094\"\n\"7\",0.1,\"0.000360364404233746\"\n\"7\",0.2,\"0.00705456522291921\"\n\"7\",0.3,\"0.0658142768200272\"\n\"7\",0.4,\"0.390487896716269\"\n\"7\",0.5,\"1.66070919948278\"\n\"7\",0.6,\"5.41722591000498\"\n\"7\",0.7,\"14.185619072845\"\n\"7\",0.8,\"30.8738916128804\"\n\"7\",0.9,\"57.4919738664582\"\n\"7\",1,\"93.9825770978708\"\n\"7.5\",0.1,\"0.000110849166256336\"\n\"7.5\",0.2,\"0.00234250824690475\"\n\"7.5\",0.3,\"0.0236746019769677\"\n\"7.5\",0.4,\"0.15267336164011\"\n\"7.5\",0.5,\"0.707761721873402\"\n\"7.5\",0.6,\"2.52180276050603\"\n\"7.5\",0.7,\"7.21945332476101\"\n\"7.5\",0.8,\"17.1645811929246\"\n\"7.5\",0.9,\"34.8187763557551\"\n\"7.5\",1,\"61.6927087862605\"\n\"8\",0.1,\"0\"\n\"8\",0.2,\"0.000110681910293541\"\n\"8\",0.3,\"0.00233897372801368\"\n\"8\",0.4,\"0.0236388802978502\"\n\"8\",0.5,\"0.152442998787986\"\n\"8\",0.6,\"0.706693807948386\"\n\"8\",0.7,\"2.51799771114993\"\n\"8\",0.8,\"7.20856017456902\"\n\"8\",0.9,\"17.138682229041\"\n\"8\",1,\"34.7662396686567\""
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {}
      },
      "values": "\"domain\"\n\"0\"\n\"0.5\"\n\"1\"\n\"1.5\"\n\"2\"\n\"2.5\"\n\"3\"\n\"3.5\"\n\"4\"\n\"4.5\"\n\"5\"\n\"5.5\"\n\"6\"\n\"6.5\"\n\"7\"\n\"7.5\"\n\"8\""
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0.055\n1.045"
    }
  ],
  "scales": [
    {
      "name": "x",
      "type": "ordinal",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "points": true,
      "sort": false,
      "range": "width",
      "padding": 0.5
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "fill": {
            "value": "#000000"
          },
          "x": {
            "scale": "x",
            "field": "data.x"
          },
          "y": {
            "scale": "y",
            "field": "data.t"
          },
          "size": {
            "field": "data.factor(BOD * 25)"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "x"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "t"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 480
  },
  "handlers": null
};
ggvis.getPlot("plot_id947932444").parseSpec(plot_id947932444_spec);
</script> The condition where x = <em>0</em> and t = <em>0</em> are ignored.</p>
</div>
<div id="see-more" class="section level1">
<h1>See more</h1>
<p>The HTML format document of this report can be available in <a href="https://rpubs.com/Hoas_xyz/431463" class="uri">https://rpubs.com/Hoas_xyz/431463</a>.</p>
</div>

<a href="https://hoas.xyz/post/the-difference-method/index.md">查看本文 Markdown 版本 »</a>