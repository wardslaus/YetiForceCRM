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
<div id="edit_project_modal" class="modal hide fade" style="z-index: 9999999;">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h3>{vtranslate('FIELD_LIST', $MODULE_NAME)}</h3>
    </div>
    <form action="index.php" method="post" name="edit_project_form">

        <div class="modal-body">

            <input type="hidden" name='module' value="OSSProjectTemplates" />
            <input type="hidden" name='base_module' value="Project" />
            <input type="hidden" name='action' value="UpdateTemplate" />
            <input type="hidden" name='parent' value="Settings" />
            <input type="hidden" name='tpl_id' value="" />
            <input type="hidden" name='back_view' value="Index" />

            <table class="table">
                <tr>
                    <td>{vtranslate('LBL_TPL_NAME', $MODULE_NAME)}</td>
                    <td><input class="required" name="tpl_name" value="" type="text" /></td>
                </tr>
                {foreach from=$FIELD_HTML_EDIT key=key item=item}
                    <tr>
                        <td>{vtranslate($item.label, 'Project')}</td>
                        <td>{$item.html}</td>
                    </tr>
                {/foreach}
            </table>
        </div>
        <div class="modal-footer">
            <a href="#" class="btn" data-dismiss="modal">{vtranslate('No', $MODULE_NAME)}</a>
            <button class="btn btn-danger okay-button" >{vtranslate('Save', $MODULE_NAME)}</button>
        </div>      
    </form>
</div>