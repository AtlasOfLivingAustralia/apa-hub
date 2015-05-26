<g:set var="orgNameLong" value="${grailsApplication.config.skin.orgNameLong}"/>
<g:set var="orgNameShort" value="${grailsApplication.config.skin.orgNameShort}"/>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <alatag:addApplicationMetaTags />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    %{--<link rel="shortcut icon" type="image/x-icon" href="favicon.ico">--}%

    <title><g:layoutTitle /></title>

    <r:require modules="apa" />

    <style type="text/css">
    body {
        background-color: #ffffff !important;
    }
    #breadcrumb {
        margin-top: 10px;
    }
    #main-content #searchInfoRow #customiseFacetsButton > .dropdown-menu {
        background-color: #ffffff;
    }
    #footer {
        margin: 20px;
        padding-top: 10px;
        border-top: 1px solid #CCC;
        font-size: 12px;
        background-color: #000000;
        color: #FFFFFF;
    }
    #content .nav-tabs > li.active > a {
        background-color: #ffffff;
    }
    .nav {
        margin-top: 20px;
    }
    body > #main-content {
        margin-top: 0px;
    }

    </style>
    <r:script disposition='head'>
        // initialise plugins
        jQuery(function(){
            // autocomplete on navbar search input
            jQuery("form#search-form-2011 input#search-2011, form#search-inpage input#search, input#search-2013").autocomplete('http://bie.ala.org.au/search/auto.jsonp', {
                extraParams: {limit: 100},
                dataType: 'jsonp',
                parse: function(data) {
                    var rows = new Array();
                    data = data.autoCompleteList;
                    for(var i=0; i<data.length; i++) {
                        rows[i] = {
                            data:data[i],
                            value: data[i].matchedNames[0],
                            result: data[i].matchedNames[0]
                        };
                    }
                    return rows;
                },
                matchSubset: false,
                formatItem: function(row, i, n) {
                    return row.matchedNames[0];
                },
                cacheLength: 10,
                minChars: 3,
                scroll: false,
                max: 10,
                selectFirst: false
            });

            // Mobile/desktop toggle
            // TODO: set a cookie so user's choice is remembered across pages
            var responsiveCssFile = $("#responsiveCss").attr("href"); // remember set href
            $(".toggleResponsive").click(function(e) {
                e.preventDefault();
                $(this).find("i").toggleClass("icon-resize-small icon-resize-full");
                var currentHref = $("#responsiveCss").attr("href");
                if (currentHref) {
                    $("#responsiveCss").attr("href", ""); // set to desktop (fixed)
                    $(this).find("span").html("Mobile");
                } else {
                    $("#responsiveCss").attr("href", responsiveCssFile); // set to mobile (responsive)
                    $(this).find("span").html("Desktop");
                }
            });

            $('.helphover').popover({animation: true, trigger:'hover'});
        });
    </r:script>
    <r:layoutResources/>
    <g:layoutHead />
</head>
<body class="${pageProperty(name:'body.class')?:'nav-collections'}" id="${pageProperty(name:'body.id')}" onload="${pageProperty(name:'body.onload')}">
<g:set var="fluidLayout" value="${grailsApplication.config.skin.fluidLayout?.toBoolean()}"/>
<div class="navbar navbar-inverse navbar-static-top">
    <div class="navbar-inner ">
        <div class="${fluidLayout?'container-fluid':'container'}">
            <div class="span8">
                <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="brand" href="index" style="font-size: 24px; line-height: 32px; color: #dd7700">&nbsp;&nbsp;${raw(orgNameLong)}&nbsp;&nbsp;</a>
                <div class="nav-collapse collapse" style="font-size: 18px; line-height: 24px; padding-top: 6px;">
                    <ul class="nav">
                        <li><a href="index">Home</a></li>
                        <li><a href="about">About</a></li>
                        <li><a href="contact">Contact</a></li>
                    </ul>
                </div><!--/.nav-collapse -->
            </div>
            <div class="span4">
                <div class="controls" style="padding-top: 12px">
                    <div class="input-append">
                        <input type="text" name="taxa" id="taxa" class="input-large">
                        <button id="locationSearch" type="submit" class="btn"><g:message code="home.index.simsplesearch.button" default="Search"/></button>
                    </div>
                </div>
            </div>
        </div><!--/.container-fluid -->
    </div><!--/.navbar-inner -->
</div><!--/.navbar -->


<div class="${fluidLayout?'container-fluid':'container'}" id="main-content">
    <g:layoutBody />
</div><!--/.container-->

<div id="footer">
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span4">
                <a class="brand" href="http://www.flinders.edu.au/" style="">
                    <g:img dir="/images" file="FU_logo_inverted_sm.jpg" alt="Flinders University" />
                </a>
                <a class="brand" href="http://www.flinders.edu.au/" style="">
                    <g:img dir="/images" file="FUPL_logo_inverted_sm.jpg" alt="Flinders Palaeontology" />
                </a>
            </div>
            <div class="span6">
                The APA is an initiative of <a href="http://www.flinders.edu.au/" style="color:#DD7700" alt="Flinders Palaeontology">Flinders Palaeontology</a>.<BR>
                This project is supported by the <a href="http://www.ands.org.au/" style="color:#DD7700" alt="Australian National Data Service">Australian National Data Service</a> (ANDS). ANDS is supported by the Australian Government through the National Collaborative Research Infrastructure Strategy Program.
            </div>
            <div class="span2" style="text-align:right">
                <a href="http://ala.org.au/">
                    <r:img dir="images" file="atlas-poweredby_rgb-lightbg.png" plugin="biocache-hubs" alt="Powered by ALA logo"/></a>
            </div>
        </div>
    </div>
</div><!--/#footer -->
<br/>

<!-- JS resources-->
<r:layoutResources/>
</body>
</html>