<%@ page import="au.org.ala.biocache.hubs.FacetsName; org.apache.commons.lang.StringUtils" contentType="text/html;charset=UTF-8" %>
<%@ page import="org.springframework.web.servlet.support.RequestContextUtils; au.org.ala.biocache.hubs.FacetsName; org.apache.commons.lang.StringUtils" contentType="text/html;charset=UTF-8" %>
<g:set var="hubDisplayName" value="${grailsApplication.config.skin.orgNameLong}"/>
<g:set var="biocacheServiceUrl" value="${grailsApplication.config.biocache.baseUrl}"/>
<g:set var="serverName" value="${grailsApplication.config.serverName?:grailsApplication.config.biocache.baseUrl}"/>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <title>${grailsApplication.config.skin.orgNameLong}</title>
</head>

<body>
<div id="headingBar" class="heading-bar">
    <g:img dir="/images" file="FUPL_alcoota_strip.jpg" alt="Alcoota Station" />
</div>
<g:if test="${flash.message}">
    <div class="message alert alert-info">
        <button type="button" class="close" onclick="$(this).parent().hide()">×</button>
        <b><g:message code="home.index.body.alert" default="Alert:"/></b> ${raw(flash.message)}
    </div>
</g:if>
<div class="row-fluid" id="content">
    <div class="span4">
        <h3 style="width:100%;color:#DD7700">The APA</h3>
        The Atlas of Prehistoric Australia is a storehouse of information on the occurrences of organisms through
        time and space. It is the deep-time add-on to the ALA, and emphasises the continuum between past and present,
        and the valuable role that historical data on taxonomy, ecology and environment can play in improving our
        understanding of Australia’s unique biota.
    </div>
    <div class="span8">
        <h3 style="width:100%;color:#DD7700">Search for records in ${raw(hubDisplayName)}</h3>
        <div class="tabbable">
            <ul class="nav nav-tabs" id="searchTabs">
                <li class = "active"><a id="t1" href="#simpleSearch" data-toggle="tab"><g:message code="home.index.navigator01" default="Simple search"/></a></li>
                <li><a id="t2" href="#advanceSearch" data-toggle="tab"><g:message code="home.index.navigator02" default="Advanced search"/></a></li>
                <li><a id="t3" href="#taxaUpload" data-toggle="tab"><g:message code="home.index.navigator03" default="Batch taxon search"/></a></li>
                <li><a id="t4" href="#catalogUpload" data-toggle="tab"><g:message code="home.index.navigator04" default="Catalogue number search"/></a></li>
                <li><a id="t5" href="#spatialSearch" data-toggle="tab"><g:message code="home.index.navigator05" default="Spatial search"/></a></li>
            </ul>
        </div>
        <div class="tab-content searchPage">
            <div id="simpleSearch" class="tab-pane active">
                <form name="simpleSearchForm" id="simpleSearchForm" action="${request.contextPath}/occurrences/search" method="GET">
                    <br/>
                    <div class="controls">
                        <div class="input-append">
                            <input type="text" name="taxa" id="taxa" class="input-xxlarge">
                            <button id="locationSearch" type="submit" class="btn"><g:message code="home.index.simsplesearch.button" default="Search"/></button>
                        </div>
                    </div>
                    <div>
                        <br/>
                        <span style="font-size: 12px; color: #444;">
                            <b><g:message code="home.index.simsplesearch.span" default="Note: the simple search attempts to match a known species/taxon - by its scientific name or common name. If there are no name matches, a full text search will be performed on your query"/>
                        </span>
                    </div>
                </form>
            </div><!-- end simpleSearch div -->
            <div id="advanceSearch" class="tab-pane">
                <form name="advancedSearchForm" id="advancedSearchForm" action="${request.contextPath}/advancedSearch" method="POST">
                    <input type="text" id="solrQuery" name="q" style="position:absolute;left:-9999px;" value="${params.q}"/>
                    <input type="hidden" name="nameType" value="matched_name_children"/>
                    <b><g:message code="advancedsearch.title01" default="Find records that have"/></b>
                    <table border="0" width="100" cellspacing="2" class="compact">
                    <thead/>
                        <tbody>
                        <tr>
                            <td class="labels"><g:message code="advancedsearch.table01col01.title" default="ALL of these words (full text)"/></td>
                            <td>
                                <input type="text" name="text" id="text" class="dataset" placeholder="" size="80" value="${params.text}"/>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <b><g:message code="advancedsearch.title02" default="Find records for FANNY of the following taxa (matched/processed taxon concepts)"/></b>
                    <table border="0" width="100" cellspacing="2" class="compact">
                        <thead/>
                        <tbody>
                        <g:each in="${1..4}" var="i">
                            <g:set var="lsidParam" value="lsid_${i}"/>
                            <tr style="" id="taxon_row_${i}">
                                <td class="labels"><g:message code="advancedsearch.table02col01.title" default="Species/Taxon"/></td>
                                <td>
                                    <input type="text" value="" id="taxa_${i}" name="taxonText" class="name_autocomplete" size="60">
                                    <input type="hidden" name="lsid" class="lsidInput" id="taxa_${i}" value=""/>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                    <b><g:message code="advancedsearch.title03" default="Find records that specify the following scientific name (verbatim/unprocessed name)"/></b>
                    <table border="0" width="100" cellspacing="2" class="compact">
                        <thead/>
                        <tbody>
                        <tr>
                            <td class="labels"><g:message code="advancedsearch.table03col01.title" default="Raw Scientific Name"/></td>
                            <td>
                                <input type="text" name="raw_taxon_name" id="raw_taxon_name" class="dataset" placeholder="" size="60" value=""/>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <b><g:message code="advancedsearch.title04" default="Find records from the following species group"/></b>
                    <table border="0" width="100" cellspacing="2" class="compact">
                        <thead/>
                        <tbody>
                        <tr>
                            <td class="labels"><g:message code="advancedsearch.table04col01.title" default="Species Group"/></td>
                            <td>
                                <select class="species_group" name="species_group" id="species_group">
                                    <option value=""><g:message code="advancedsearch.table04col01.option.label" default="-- select a species group --"/></option>
                                    <g:each var="group" in="${request.getAttribute(FacetsName.SPECIES_GROUP.fieldname)}">
                                        <option value="${group.key}">${group.value}</option>
                                    </g:each>
                                </select>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <b><g:message code="advancedsearch.title05" default="Find records from the following institution or collection"/></b>
                    <table border="0" width="100" cellspacing="2" class="compact">
                        <thead/>
                        <tbody>
                        <tr>
                            <td class="labels"><g:message code="advancedsearch.table05col01.title" default="Institution or Collection"/></td>
                            <td>
                                <select class="institution_uid collection_uid" name="institution_collection" id="institution_collection">
                                    <option value=""><g:message code="advancedsearch.table05col01.option01.label" default="-- select an institution or collection --"/></option>
                                    <g:each var="inst" in="${request.getAttribute(FacetsName.INSTITUTION.fieldname)}">
                                        <optgroup label="${inst.value}">
                                            <option value="${inst.key}"><g:message code="advancedsearch.table05col01.option02.label" default="All records from"/> ${inst.value}</option>
                                            <g:each var="coll" in="${request.getAttribute(FacetsName.COLLECTION.fieldname)}">
                                                <g:if test="${inst.key == 'in13' && StringUtils.startsWith(coll.value, inst.value)}">
                                                    <option value="${coll.key}">${StringUtils.replace(StringUtils.replace(coll.value, inst.value, ""), " - " ,"")} <g:message code="advancedsearch.table05col01.option03.label" default="Collection"/></option>
                                                </g:if>
                                                <g:elseif test="${inst.key == 'in6' && StringUtils.startsWith(coll.value, 'Australian National')}">
                                                <%-- <option value="${coll.key}">${fn:replace(coll.value,"Australian National ", "")}</option> --%>
                                                    <option value="${coll.key}">${coll.value}</option>
                                                </g:elseif>
                                                <g:elseif test="${StringUtils.startsWith(coll.value, inst.value)}">
                                                    <option value="${coll.key}">${StringUtils.replace(coll.value, inst.value, "")}</option>
                                                </g:elseif>
                                            </g:each>
                                        </optgroup>
                                    </g:each>
                                </select>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <b><g:message code="advancedsearch.title06" default="Find records from the following regions"/></b>
                    <table border="0" width="100" cellspacing="2" class="compact">
                        <thead/>
                        <tbody>
                        <tr>
                            <td class="labels"><g:message code="advancedsearch.table06col01.title" default="Country"/></td>
                            <td>
                                <select class="country" name="country" id="country">
                                    <option value=""><g:message code="advancedsearch.table06col01.option.label" default="-- select a country --"/></option>
                                    <g:each var="country" in="${request.getAttribute(FacetsName.COUNTRIES.fieldname)}">
                                        <option value="${country.key}">${country.value}</option>
                                    </g:each>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="labels"><g:message code="advancedsearch.table06col02.title" default="State/Territory"/></td>
                            <td>
                               <select class="state" name="state" id="state">
                                    <option value=""><g:message code="advancedsearch.table06col02.option.label" default="-- select a state/territory --"/></option>
                                    <g:each var="state" in="${request.getAttribute(FacetsName.STATES.fieldname)}">
                                        <option value="${state.key}">${state.value}</option>
                                    </g:each>
                                </select>
                            </td>
                        </tr>
                        <g:set var="autoPlaceholder" value="start typing and select from the autocomplete drop-down list"/>
                        <g:if test="${request.getAttribute(FacetsName.IBRA.fieldname) && request.getAttribute(FacetsName.IBRA.fieldname).size() > 1}">
                            <tr>
                                <td class="labels"><abbr title="Interim Biogeographic Regionalisation of Australia">IBRA</abbr> <g:message code="advancedsearch.table06col03.title" default="region"/></td>
                                <td>
                                    <select class="biogeographic_region" name="ibra" id="ibra">
                                        <option value=""><g:message code="advancedsearch.table06col03.option.label" default="-- select an IBRA region --"/></option>
                                        <g:each var="region" in="${request.getAttribute(FacetsName.IBRA.fieldname)}">
                                            <option value="${region.key}">${region.value}</option>
                                       </g:each>
                                    </select>
                                </td>
                            </tr>
                        </g:if>
                        <g:if test="${request.getAttribute(FacetsName.IMCRA.fieldname) && request.getAttribute(FacetsName.IMCRA.fieldname).size() > 1}">
                            <tr>
                                <td class="labels"><abbr title="Integrated Marine and Coastal Regionalisation of Australia">IMCRA</abbr> <g:message code="advancedsearch.table06col04.title" default="region"/></td>
                                <td>
                                    <select class="biogeographic_region" name="imcra" id="imcra">
                                        <option value=""><g:message code="advancedsearch.table06col04.option.label" default="-- select an IMCRA region --"/></option>
                                        <g:each var="region" in="${request.getAttribute(FacetsName.IMCRA.fieldname)}">
                                            <option value="${region.key}">${region.value}</option>
                                        </g:each>
                                    </select>
                                </td>
                            </tr>
                        </g:if>
                        <g:if test="${request.getAttribute(FacetsName.LGA.fieldname) && request.getAttribute(FacetsName.LGA.fieldname).size() > 1}">
                            <tr>
                                <td class="labels"><g:message code="advancedsearch.table06col05.title" default="Local Govt. Area"/></td>
                                <td>
                                    <select class="lga" name="cl959" id="cl959">
                                        <option value=""><g:message code="advancedsearch.table06col05.option.label" default="-- select local government area--"/></option>
                                        <g:each var="region" in="${request.getAttribute(FacetsName.LGA.fieldname)}">
                                            <option value="${region.key}">${region.value}</option>
                                        </g:each>
                                    </select>
                                </td>
                            </tr>
                        </g:if>
                        </tbody>
                    </table>
                    <g:if test="${request.getAttribute(FacetsName.TYPE_STATUS.fieldname) && request.getAttribute(FacetsName.TYPE_STATUS.fieldname).size() > 1}">
                        <b><g:message code="advancedsearch.title07" default="Find records from the following type status"/></b>
                        <table border="0" width="100" cellspacing="2" class="compact">
                            <thead/>
                            <tbody>
                            <tr>
                                <td class="labels"><g:message code="advancedsearch.table07col01.title" default="Type Status"/></td>
                                <td>
                                    <select class="type_status" name="type_status" id="type_status">
                                        <option value=""><g:message code="advancedsearch.table07col01.option.label" default="-- select a type status --"/></option>
                                        <g:each var="type" in="${request.getAttribute(FacetsName.TYPE_STATUS.fieldname)}">
                                            <option value="${type.key}">${type.value}</option>
                                        </g:each>
                                    </select>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </g:if>
                    <g:if test="${request.getAttribute(FacetsName.BASIS_OF_RECORD.fieldname) && request.getAttribute(FacetsName.BASIS_OF_RECORD.fieldname).size() > 1}">
                        <b><g:message code="advancedsearch.title08" default="Find records from the following basis of record (record type)"/></b>
                        <table border="0" width="100" cellspacing="2" class="compact">
                            <thead/>
                            <tbody>
                            <tr>
                                <td class="labels"><g:message code="advancedsearch.table08col01.title" default="Basis of record"/></td>
                                <td>
                                    <select class="basis_of_record" name="basis_of_record" id="basis_of_record">
                                        <option value=""><g:message code="advancedsearch.table08col01.option.label" default="-- select a basis of record --"/></option>
                                        <g:each var="bor" in="${request.getAttribute(FacetsName.BASIS_OF_RECORD.fieldname)}">
                                            <option value="${bor.key}"><g:message code="${bor.value}"/></option>
                                        </g:each>
                                    </select>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </g:if>
                    <b><g:message code="advancedsearch.title09" default="Find records with the following dataset fields"/></b>
                    <table border="0" width="100" cellspacing="2" class="compact">
                        <thead/>
                        <tbody>
                        <tr>
                            <td class="labels"><g:message code="advancedsearch.table09col01.title" default="Catalogue Number"/></td>
                            <td>
                                <input type="text" name="catalogue_number" id="catalogue_number" class="dataset" placeholder="" value=""/>
                            </td>
                        </tr>
                        <tr>
                            <td class="labels"><g:message code="advancedsearch.table09col02.title" default="Record Number"/></td>
                            <td>
                                <input type="text" name="record_number" id="record_number" class="dataset" placeholder="" value=""/>
                            </td>
                        </tr>
                        <%--<tr>
                            <td class="labels">Collector Name</td>
                            <td>
                                 <input type="text" name="collector" id="collector" class="dataset" placeholder="" value=""/>
                            </td>
                        </tr> --%>
                        </tbody>
                    </table>
                    <b><g:message code="advancedsearch.title10" default="Find records within the following date range"/></b>
                    <table border="0" width="100" cellspacing="2" class="compact">
                        <thead/>
                        <tbody>
                        <tr>
                            <td class="labels"><g:message code="advancedsearch.table10col01.title" default="Begin Date"/></td>
                            <td>
                                <input type="text" name="start_date" id="startDate" class="occurrence_date" placeholder="" value=""/>
                                <g:message code="advancedsearch.table10col01.des" default="(YYYY-MM-DD) leave blank for earliest record date"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="labels"><g:message code="advancedsearch.table10col02.title" default="End Date"/></td>
                            <td>
                                <input type="text" name="end_date" id="endDate" class="occurrence_date" placeholder="" value=""/>
                                <g:message code="advancedsearch.table10col02.des" default="(YYYY-MM-DD) leave blank for most recent record date"/>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <input type="submit" value=<g:message code="advancedsearch.button.submit" default="Search"/> class="btn btn-primary" />
                &nbsp;&nbsp;
                    <input type="reset" value="Clear all" id="clearAll" class="btn" onclick="$('input#solrQuery').val(''); $('input.clear_taxon').click(); return true;"/>
                </form>
            </div><!-- end #advancedSearch div -->
            <div id="taxaUpload" class="tab-pane">
                <form name="taxaUploadForm" id="taxaUploadForm" action="${biocacheServiceUrl}/occurrences/batchSearch" method="POST">
                    <p><g:message code="home.index.taxaupload.des01" default="Enter a list of taxon names/scientific names, one name per line (common names not currently supported)."/></p>
                    <%--<p><input type="hidden" name="MAX_FILE_SIZE" value="2048" /><input type="file" /></p>--%>
                    <p><textarea name="queries" id="raw_names" class="span6" rows="15" cols="60"></textarea></p>
                    <p>
                        <%--<input type="submit" name="action" value="Download" />--%>
                        <%--&nbsp;OR&nbsp;--%>
                        <input type="hidden" name="redirectBase" value="${serverName}${request.contextPath}/occurrences/search"/>
                        <input type="hidden" name="field" value="raw_name"/>
                        <input type="submit" name="action" value=<g:message code="home.index.taxaupload.button01" default="Search"/> class="btn" /></p>
                </form>
            </div><!-- end #uploadDiv div -->
            <div id="catalogUpload" class="tab-pane">
                <form name="catalogUploadForm" id="catalogUploadForm" action="${biocacheServiceUrl}/occurrences/batchSearch" method="POST">
                    <p><g:message code="home.index.catalogupload.des01" default="Enter a list of catalogue numbers (one number per line)."/></p>
                    <%--<p><input type="hidden" name="MAX_FILE_SIZE" value="2048" /><input type="file" /></p>--%>
                    <p><textarea name="queries" id="catalogue_numbers" class="span6" rows="15" cols="60"></textarea></p>
                    <p>
                        <%--<input type="submit" name="action" value="Download" />--%>
                        <%--&nbsp;OR&nbsp;--%>
                        <input type="hidden" name="redirectBase" value="${serverName}${request.contextPath}/occurrences/search"/>
                        <input type="hidden" name="field" value="catalogue_number"/>
                        <input type="submit" name="action" value=<g:message code="home.index.catalogupload.button01" default="Search"/> class="btn"/></p>
                </form>
            </div><!-- end #catalogUploadDiv div -->
            <div id="spatialSearch" class="tab-pane">
                <div class="row-fluid">
                    <div class="span3">
                        <div>
                            <g:message code="search.map.helpText" default="Select one of the draw tools (polygon, rectangle, circle), draw a shape and click the search link that pops up."/>
                        </div>
                        <br>
                        <div class="accordion accordion-caret" id="accordion2">
                            <div class="accordion-group">
                                <div class="accordion-heading">
                                    <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
                                        <g:message code="search.map.importToggle" default="Import WKT"/>
                                    </a>
                                </div>
                                <div id="collapseOne" class="accordion-body collapse">
                                    <div class="accordion-inner">
                                        <p><g:message code="search.map.importText"/></p>
                                        <p><g:message code="search.map.wktHelpText" default="Optionally, paste a WKT string: "/></p>
                                        <textarea type="text" id="wktInput"></textarea>
                                        <br>
                                        <button class="btn btn-small" id="addWkt"><g:message code="search.map.wktButtonText" default="Add to map"/></button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="span9">
                        <div id="leafletMap" style="height:600px;"></div>
                    </div>
                </div>
            </div><!-- end #spatialSearch  -->
        </div><!-- end .tab-content -->
    </div><!-- end .span12 -->
</div><!-- end .row-fluid -->
</body>
</html>
