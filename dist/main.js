(function(){var a;a={readingAverage:{low:250,high:300},message:{first:"There is approximately ",last:" minutes left of this article."},init:function(){return a.loadScripts(),$.noConflict(),jQuery(document).ready(function(b){var c,d,e,f,g,h,i,j,k,l,m,n,o;for(f=0,e=null,b("p").parent().each(function(){return b("p",this).length>f?(f=b("p",this).length,e=b(this)):void 0}),i=b("body").scrollTop(),l=0,k=b("h1,h2,h3,h4,h5,h6,p,blockquote",e),k.each(function(a){return b(this).offset().top>i?(l=a,!1):void 0}),m=0,h=n=l,o=k.length-1;o>=l?o>=n:n>=o;h=o>=l?++n:--n)m+=k.eq(h).text().split(" ").length;return g=a.getFormattedMinutes(m/a.readingAverage.low),d="width: 150px;height: 150px;position: fixed;top: 50%;left: 50%;margin-top: -75px;margin-left: -75px;background: rgba(0,0,0,.85);display: table;border-radius: 10px;z-index: 9999;",j="color: white;display: table-cell;vertical-align: middle;text-align: center;font-size: 50px;font-family: Helvetica;",c=b('<div style="'+d+'"><span style="'+j+'">'+g+"</span></div>"),b("body").append(c),c.delay(1e3).fadeOut(350,function(){return c.remove()})})},getFormattedMinutes:function(b){return b=String(b).split("."),b[0]+":"+a.getFormattedBelowTen(Math.round(60*Number("0."+b[1])))},getFormattedBelowTen:function(a){return 10>a?"0"+a:a},loadScripts:function(){var a,b,c,d,e,f;for(a=["https://code.jquery.com/jquery-1.11.0.min.js"],f=[],d=0,e=a.length;e>d;d++)c=a[d],b=document.createElement("script"),b.type="text/javascript",b.src=c,f.push(document.body.appendChild(b));return f}},a.init()}).call(this);