{assign var=modules value=$SAVED_DATA['modules']}
<div class="row-fluid">
	<div class="span12 padding-bottom1per">
		<h5 class="padding-bottom1per"><strong>{vtranslate('Select module', 'DataAccess')}:</strong></h5>
		<select name="modules" class="marginLeftZero span6 select2">
			{foreach item=item key=key from=$CONFIG['modules']}
				<option value="{$item}" {if $item == $modules} selected {/if} >{vtranslate($item, 'Calendar')}</option>
			{/foreach}
		</select>
	</div>
</div>
