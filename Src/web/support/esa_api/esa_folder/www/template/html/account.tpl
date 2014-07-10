<!DOCTYPE html>
<html lang="en">

   {include file="head.tpl"/}     


  <body>

     {include file="navbar.tpl"/}  

    <div class="container-fluid" itemscope itemtype="{$host/}/profile/esa_api.xml">
        <div class="col-sm-12">       
          <form class="form-inline well" id="registerHere" method='POST' action='{$host/}/account' itemprop="update">
            <fieldset>
              <legend>Account Information</legend>
              <div class="span3"><p>The information in this page is used by Eiffel Software should we need to contact you.
               We will never share this information with other companies.
               Please provide as much information as possible so we can better assist you.</p>
              </div> 

              <div class="row">
                <div class="col-sm-12">
                  <div class="row">
                
                    <div class="col-sm-4">
                        <label class="control-label-api" itemprop="first_name">First Name</label>
                        <input type="text" class="form-control" id="input01" name="first_name" rel="popover" data-content="Enter your first" data-original-title="First Name" value="{$account.first_name/}">
                    </div>
                  </div> 
                </div>
              </div>     

              <div class="row">
                <div class="col-sm-12">
                  <div class="row">
                     <div class="col-sm-4">
                     <label class="control-label-api" itemprop="last_name">Last Name</label>
                       <input type="text" class="form-control" id="input01" name="last_name" rel="popover" data-content="Enter your last name" data-original-title="Last Name" value="{$account.last_name/}">
                    </div>
                  </div>
                </div>
               </div>   

              <div class="row">
                <div class="col-sm-12">
                  <div class="row">
                     <div class="col-sm-4">
                      <label class=" control-label-api" itemprop="email">Email</label>
                       <input type="email" class="form-control" id="input01" name="user_email" rel="popover" data-content="What’s your email address?" data-original-title="Email" value="{$account.email/}" disabled>
                     </div>
                  </div>
                </div>
              </div>   

             <div class="row">
                <div class="col-sm-12">
                  <div class="row">
                     <div class="col-sm-4">
                         <label class=" control-label-api" itemprop="country">Country</label>
                          <select class="form-control" id="input01"  data-style="btn-primary" name="country" >
                          {foreach from="$account.countries" item="item"}
                            {if condition="$item.id ~ $account.selected_country"} 
                              <option value="{$item.id/}" selected>{$item.name/}</option>
                            {/if}
                            {unless condition="$item.id ~ $account.selected_country"}
                              <option value="{$item.id/}">{$item.name/}</option>
                            {/unless}
                          {/foreach} 
                          </select>
                      </div>
                    </div>  
                 </div>
              </div>   

              <div class="row">
                <div class="col-sm-12">
                  <div class="row">
                     <div class="col-sm-4">
                      <label class="control-label-api" itemprop="region">Region</label>
                      <input type="text" class="form-control" id="input01" name="user_region" rel="popover" data-content="Enter your region" data-original-title="Region" value="{$account.region/}">
                     </div>
                   </div> 
                </div>
              </div>
                
              <div class="row">
                <div class="col-sm-12">
                  <div class="row">
                     <div class="col-sm-4">
                      <label class="control-label-api" itemprop="position">Position</label>
                        <input type="text" class="form-control" id="input01" name="user_position" rel="popover" data-content="Enter your position" data-original-title="Position" value="{$account.position/}">
                    </div>
                  </div>
                </div>
              </div>      

              <div class="row">
                <div class="col-sm-12">
                  <div class="row">
                     <div class="col-sm-4">
                      <label class="control-label-api" itemprop="city">City</label>
                        <input type="text" class="form-control" id="input01" name="user_city" rel="popover" data-content="Enter your city" data-original-title="city" value="{$account.city/}">
                     </div>
                  </div>
                </div> 
              </div>      

              <div class="row">
                <div class="col-sm-12">
                  <div class="row">
                     <div class="col-sm-4">
                        <label class="control-label-api" itemprop="address">Address</label>
                        <input type="text" class="form-control" id="input01" name="user_address" rel="popover" data-content="Enter your address" data-original-title="Address" value="{$account.address/}">
                    </div>
                  </div>
                </div>
              </div>   

             <div class="row">
                <div class="col-sm-12">
                  <div class="row">
                     <div class="col-sm-4">
                        <label class="control-label-api" itemprop="postal_code">Postal Code</label>
                        <input type="text" class="form-control" id="input01" name="user_postal_code" rel="popover" data-content="Enter your postal code" data-original-title="Postal Code" value="{$account.postal_code/}">
                      </div>
                   </div>
                 </div>
              </div>      

             <div class="row">
                <div class="col-sm-12">
                  <div class="row">
                     <div class="col-sm-4">
                      <label class="control-label-api" itemprop="telephone">Telephone</label>
                      <input type="tel" class="form-control" id="input01" name="user_phone" rel="popover" data-content="Enter your phone" data-original-title="phone" value="{$account.telephone/}">
                    </div>
                  </div>
                </div>
              </div>    
                    

             <div class="row">
                <div class="col-sm-12">
                  <div class="row">
                     <div class="col-sm-4">
                      <label class="control-label-api" itemprop="fax">Fax</label>
                      <input type="text" class="form-control" id="input01" name="user_fax" rel="popover" data-content="Enter your fax" data-original-title="Address" value="{$account.fax/}">
                    </div>
                  </div>
                </div>
              </div>      

            
              <input type="hidden" class="input-xlarge" id="input01" name="user_name" rel="popover"  value="{$account.username/}">
              </br>
              
              <div class="row">
                <div class="col-sm-12">
                  <div class="row">
                    <div class="col-sm-4">
                    <button type="submit" class="btn btn-primary" id="input01">Update My Account</button>
                    <input type="reset" class="btn btn-default" value="Reset">
                 </div>
              </div>
             </div> 
            </div>     
               
              {if isset="$has_error"} 
                <div class="control-group">
                  <label class="control-label">Errors</label>
                    {foreach from="$form.errors" item="item"}
                        {$item/} <br>
                     {/foreach}
                 </div>    
               {/if}     
              
          </fieldset>
          </form>
        </div>
    </div>
    <!-- Placed at the end of the document so the pages load faster -->


    
    {include file="optional_enhancement_js.tpl"/} 
  </body>
</html>