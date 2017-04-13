<#assign jawr=JspTaglibs["/WEB-INF/tld/jawr.tld"]>

<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1" />
<meta name="description" content="${selfServiceConfig.applicationName}" />
<meta name="keywords" content="${selfServiceConfig.applicationName},u.achieve,u.achieve self service,audit,interactive,degree,graduate,college,progress,track" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${title}</title>
<link rel="icon" type="image/ico" href="<@s.url relativeUrl="/images/favicon.ico" />"/>
<@jawr.style src="/bundles/jquery.css" media="all" />
<@jawr.style src="/bundles/bootstrap.css"  media="all"/>
<@jawr.style src="/bundles/fontawesome.css"  media="all" />
<@jawr.style src="/bundles/base.css" media="all" />
<@jawr.style src="/bundles/default.css" title="default" media="all" />
<@jawr.style src="/bundles/highcontrast.css" title="highcontrast"  media="all"/>

<@jawr.style src="/bundles/common.css" media="all" />
<@jawr.style src="/bundles/datetime.css"/>

<@jawr.script src="/bundles/base.js" />
<@jawr.script src="/bundles/accessibility.js" />

<@jawr.script src="/bundles/datetime.js" />

		<!--[if lt IE 9]>
          <@jawr.script src="/bundles/respond.js" />
        <![endif]-->
        
<#if selfServiceConfig.disableFrames >
<script type="text/javascript"> if (top.frames.length!=0) top.location=self.document.location; </script>
</#if>

