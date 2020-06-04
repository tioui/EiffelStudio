note
	description: "Summary description for {ES_CLOUD_LICENSES_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_LICENSES_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_with_cms_api
		end

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_mod: ES_CLOUD_MODULE; a_mod_api: ES_CLOUD_API)
		do
			es_cloud_module := a_mod
			make_with_cms_api (a_mod_api.cms_api)
			es_cloud_api := a_mod_api
		end

feature -- API

	es_cloud_module: ES_CLOUD_MODULE

	es_cloud_api: ES_CLOUD_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		do
			if req.is_get_request_method then
				if attached req.path_parameter ("license_key") as l_lic_key then
					process_license_get (l_lic_key.string_representation, req, res)
				else
					process_get (req, res)
				end
			elseif req.is_post_request_method then
				process_post (req, res)
			else
				send_bad_request (req, res)
			end
		end

	process_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING_8
--			l_plan: ES_CLOUD_PLAN
		do
			r := new_generic_response (req, res)
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)

			create s.make_empty

			s.append ("<h2>Buy a new license</h2>")

			if attached es_cloud_module.new_store_block (es_cloud_api, r) as bl then
				r.add_block (bl, "content")
				r.add_style (r.module_resource_url (es_cloud_module, "/files/css/pricing.css", Void), Void)
			end

			r.set_main_content (s)
			r.execute
		end

	process_license_get (a_lic_key: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_lic_user, l_user: ES_CLOUD_USER
			r: like new_generic_response
			s: STRING
		do
			if attached api.user as u then
				l_user := u
			end
			if
				attached es_cloud_api.license_by_key (a_lic_key) as lic
			then
				l_lic_user := es_cloud_api.user_for_license (lic)
				if
					api.has_permission ({ES_CLOUD_MODULE}.perm_manage_es_licenses) or else
					(l_lic_user /= Void and then l_user /= Void and then l_user.same_as (l_lic_user))
				then
					r := new_generic_response (req, res)
					r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
					r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
					r.set_title ("License " + html_encoded (a_lic_key))
					s := ""

					s.append ("<div class=%"es-licenses%">")
					append_license_to_html (lic, l_lic_user, s)
					s.append ("<div><a href=%"" + api.location_url (es_cloud_module.licenses_location, Void) + "%">All licenses...</a></div>")
					r.set_main_content (s)
					r.execute
				else
					send_access_denied_message (res)
--					s.append ("<div class=%"warning%">This page is restricted to authorized person!</div>")
				end
			else
				send_not_found (req, res)
			end
		end

	process_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_user: ES_CLOUD_USER
			r: like new_generic_response
			s: STRING
			l_plan: detachable ES_CLOUD_PLAN
			l_org: detachable ES_CLOUD_ORGANIZATION
			ago: DATE_TIME_AGO_CONVERTER
			l_user_has_no_license: BOOLEAN
		do
			r := new_generic_response (req, res)
			r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			r.set_title ("EiffelStudio Licenses")
			s := ""

			create ago.make

			if attached api.user as u then
				create l_user.make (u)
				s.append ("<div class=%"es-user%"><strong>Account:</strong> "+ api.html_encoded (api.real_user_display_name (u)) +"</div>")
				
					-- Organisations
				s.append ("<div class=%"es-organizations%">")
				if attached es_cloud_api.user_organizations (l_user) as l_orgs then
					across
						l_orgs as o_ic
					loop
						l_org := o_ic.item
						if es_cloud_api.is_organization_manager (l_user, l_org) then
							s.append ("<p>Manager of organization: <span class=%"es-org-title%">")
							s.append ("<a href=%"" + api.administration_path ("cloud/organizations/?org=" + l_org.id.out) + "%">")
							s.append (html_encoded (l_org.title_or_name))
							s.append ("</a></span></p>")
						else
							s.append ("<p>Member of organization: <span class=%"es-org-title%">")
							s.append (html_encoded (l_org.title_or_name))
							s.append ("</span></p>")
						end
					end
				end
				s.append ("</div>")

					-- Buy new license button
					-- FIXME: remove when licensing is live !
				if attached u.email as l_email and then l_email.ends_with_general ("@eiffel.com") then
					s.append ("<div><div class=%"es-new-license%"><form action=%""+ r.location_url ({ES_CLOUD_MODULE}.licenses_location, Void) +"%" method=%"post%"><input type=%"submit%" class=%"button%" title=%"Buy a new license%" name=%"op%" value=%"Buy new license%"></input></form></div></div>")
				end

				if
					attached l_user.cms_user.email as l_email and then
					attached es_cloud_api.email_licenses (l_email) as lst and then
					not lst.is_empty
				then
					across
						lst as ic
					loop
						es_cloud_api.move_email_license_to_user (ic.item, l_user)
						s.append ("<div>Retrieving license " + html_encoded (ic.item.license.key))
						s.append (" ... </div>")
					end
				end

					-- List of licenses
				s.append ("<div class=%"es-licenses%">")
				if attached es_cloud_api.user_licenses (l_user) as lics and then not lics.is_empty then
					across
						lics as ic
					loop
						if
							attached ic.item as l_user_lic and then
							attached l_user_lic.license as lic
						then
							append_license_to_html (lic, l_user, s)
						end
					end
				else
					s.append ("Please subscribe to a license ...")
					l_user_has_no_license := True
				end
				s.append ("</div>")

				if
					l_user_has_no_license and then
					attached es_cloud_api.user_subscription (l_user) as sub
				then
					s.append ("<div class=%"es-subscription%">")
					l_plan := sub.plan
					s.append ("<p>You are subscribed to plan: <span class=%"es-plan-title%">")
					s.append (html_encoded (l_plan.title_or_name))
					s.append ("</span>")
					s.append ("<ul>")
					if attached {ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION} sub as org_sub then
						s.append (" <li class=%"organization%">As member of organization ")
						s.append (html_encoded (org_sub.organization.title_or_name))
						s.append ("</li>")
					end
					s.append ("<li class=%"creation%">Started ")
					s.append (api.date_time_to_string (sub.creation_date))
					s.append ("</li>")
					if sub.is_active then
						if attached sub.expiration_date as exp then
							s.append ("<li class=%"expiration%">Renewal date ")
							s.append (api.date_time_to_string (exp))
							s.append (" (")
							s.append (sub.days_remaining.out)
							s.append (" days remaining)")
							s.append ("</li>")
						else
							s.append ("<li class=%"status success%">ACTIVE</li>")
						end
					else
						s.append ("<li class=%"status warning%">EXPIRED</li>")
						if attached sub.expiration_date as exp then
							s.append ("<li class=%"expiration%">Expiration date ")
							s.append (api.date_time_to_string (exp))
							s.append ("</li>")
						end
					end
					s.append ("</ul>")
					s.append ("</div>")
					if sub /= Void then
						if attached {ES_CLOUD_LICENSE} es_cloud_api.converted_license_from_user_subscription (sub, Void) as lic then
							s.append ("<div>Subscription converted to license " + html_encoded (lic.key))
							s.append ("</div>")
						end
					end
				end
			else
				s.append ("<p>Please Login or Register...</p>")
			end

			r.set_main_content (s)
			r.execute
		end

	append_license_to_html (lic: ES_CLOUD_LICENSE; u: detachable ES_CLOUD_USER; s: STRING_8)
		do
			es_cloud_api.append_license_to_html (lic, u, es_cloud_module, s)
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

