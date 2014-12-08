{*<!--
/*+***********************************************************************************************************************************
 * The contents of this file are subject to the YetiForce Public License Version 1.1 (the "License"); you may not use this file except
 * in compliance with the License.
 * Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or implied.
 * See the License for the specific language governing rights and limitations under the License.
 * The Original Code is YetiForce.
 * The Initial Developer of the Original Code is YetiForce. Portions created by YetiForce are Copyright (C) www.yetiforce.com. 
 * All Rights Reserved.
 *************************************************************************************************************************************/
-->*}
<script type="text/javascript">

	Vtiger_Widget_Js('Vtiger_Graf_Widget_Js',{},{
		
        postLoadWidget: function() {
                        this._super();
                var thisInstance = this;

                        this.getContainer().on('jqplotDataClick', function(ev, gridpos, datapos, neighbor, plot) {
                    var jData = thisInstance.getContainer().find('.widgetData').val();
                                var data = JSON.parse(jData);
                                var linkUrl = data[datapos][3];
                                if(linkUrl) window.location.href = linkUrl;
                        });

                        this.getContainer().on("jqplotDataHighlight", function(evt, seriesIndex, pointIndex, neighbor) {
                                $('.jqplot-event-canvas').css( 'cursor', 'pointer' );
                        });
                        this.getContainer().on("jqplotDataUnhighlight", function(evt, seriesIndex, pointIndex, neighbor) {
                                $('.jqplot-event-canvas').css( 'cursor', 'auto' );
                        });
            },

	loadChart : function() {
		var container = this.getContainer();
		var data = container.find('.widgetData').val();
		var labels = new Array();
		var value = new Array();
		var dataInfo = JSON.parse(data);
		for(var i=0; i<dataInfo.length; i++) {
			labels[i] = dataInfo[i][2];
		//	console.log(dataInfo[i][1]);
			value[i] = parseFloat(dataInfo[i][1]);
			//console.log(dataInfo[i][1]);
		}
		
		this.getPlotContainer(false).jqplot([value],  {
		//animate: !$.jqplot.use_excanvas,
			seriesDefaults: {
				renderer:jQuery.jqplot.BarRenderer,
				pointLabels: { show: true, formatString: '%d' }

			},
			axes: {
                xaxis: {
					//tickRenderer: jQuery.jqplot.CanvasAxisTickRenderer,
                    renderer: $.jqplot.CategoryAxisRenderer,
                    ticks: labels,
                },
				yaxis: {
					//min:0,
					tickOptions: {
						formatString: '%d'
					},
					pad : 1.2
				}
            },
			
            highlighter: { show: true }
		});
	},

	registerSectionClick : function() {
		this.getContainer().on('jqplotDataClick', function() {
			var sectionData = arguments[3];
			var typeMailValue = sectionData[0];
		})

	}
	});
</script>
{foreach key=index item=cssModel from=$STYLES}
	<link rel="{$cssModel->getRel()}" href="{$cssModel->getHref()}" type="{$cssModel->getType()}" media="{$cssModel->getMedia()}" />
{/foreach}
{foreach key=index item=jsModel from=$SCRIPTS}
	<script type="{$jsModel->getType()}" src="{$jsModel->getSrc()}"></script>
{/foreach}

<div class="dashboardWidgetHeader">
	<table width="100%" cellspacing="0" cellpadding="0">
	<tbody>
		<tr>
			<td class="span8">
				<div class="dashboardTitle" title="{vtranslate($WIDGET->getTitle(), $MODULE_NAME)}"><b>&nbsp;&nbsp;{vtranslate($WIDGET->getTitle(), $MODULE_NAME)}</b></div>
			</td>
			<td class="span2">
				<div>
					<select class="widgetFilter" id="owner" name="owner" style='width:70px;margin-bottom:0px'>
						<option value="{$CURRENTUSER->getId()}" >{vtranslate('LBL_MINE')}</option>
						<option value="all">{vtranslate('LBL_ALL')}</option>
                        {assign var=ALL_ACTIVEUSER_LIST value=$CURRENTUSER->getAccessibleUsers()}
                        {if count($ALL_ACTIVEUSER_LIST) gt 1}
                            <optgroup label="{vtranslate('LBL_USERS')}">
                                {foreach key=OWNER_ID item=OWNER_NAME from=$ALL_ACTIVEUSER_LIST}
                                    {if $OWNER_ID neq {$CURRENTUSER->getId()}}
                                        <option value="{$OWNER_ID}">{$OWNER_NAME}</option>
                                    {/if}
                                {/foreach}
                            </optgroup>
                        {/if}
                        {assign var=ALL_ACTIVEGROUP_LIST value=$CURRENTUSER->getAccessibleGroups()}
                        {if !empty($ALL_ACTIVEGROUP_LIST)}
                            <optgroup label="{vtranslate('LBL_GROUPS')}">
                                {foreach key=OWNER_ID item=OWNER_NAME from=$ALL_ACTIVEGROUP_LIST}
                                    <option value="{$OWNER_ID}">{$OWNER_NAME}</option>
                                {/foreach}
                            </optgroup>
                        {/if}
					</select>
				</div>
			</td>
			<td class="span2">
				<div>
					<select class="widgetFilter" id="dateFilter" name="dateFilter" style='width:70px;margin-bottom:0px'>
						<option value="Today" >{vtranslate('Today', $MODULE_NAME)}</option>
						<option value="Yesterday">{vtranslate('Yesterday', $MODULE_NAME)}</option>
						<option value="Current week">{vtranslate('Current week', $MODULE_NAME)}</option>
						<option value="Previous week">{vtranslate('Previous week', $MODULE_NAME)}</option>
						<option value="Current month">{vtranslate('Current month', $MODULE_NAME)}</option>
						<option value="Previous month">{vtranslate('Previous month', $MODULE_NAME)}</option>
						{*<option value="All">{vtranslate('All')}</option>*}
					</select>
				</div>
			</td>
			<td class="refresh span1" align="right">
				<span style="position:relative;"></span>
			</td>
			<td class="widgeticons span4" align="right">
				{include file="dashboards/DashboardHeaderIcons.tpl"|@vtemplate_path:$MODULE_NAME SETTING_EXIST=true}
			</td>
		</tr>
	</tbody>
	</table>
{*	<div class="row-fluid filterContainer hide" style="position:absolute;z-index:100001">
		<div class="row-fluid">
			<span class="span5">
				<span class="pull-right">
					{vtranslate('Expected Close Date', $MODULE_NAME)} &nbsp; {vtranslate('LBL_BETWEEN', $MODULE_NAME)}
				</span>
			</span>
			<span class="span4">
				<input type="text" name="expectedclosedate" class="dateRange widgetFilter" />
			</span>
		</div>
	</div> *}
</div>

<div class="dashboardWidgetContent" style="padding-top:0px;">
	{include file="dashboards/DashBoardWidgetContents.tpl"|@vtemplate_path:$MODULE_NAME}
</div>