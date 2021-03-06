<%--
/**
 * Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
 *
 * This file is part of Liferay Social Office. Liferay Social Office is free
 * software: you can redistribute it and/or modify it under the terms of the GNU
 * Affero General Public License as published by the Free Software Foundation,
 * either version 3 of the License, or (at your option) any later version.
 *
 * Liferay Social Office is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License
 * for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * Liferay Social Office. If not, see http://www.gnu.org/licenses/agpl-3.0.html.
 */
--%>

<%@ include file="/init.jsp" %>

<%
String redirect = ParamUtil.getString(request, "redirect");

Group group = themeDisplay.getScopeGroup();

long microblogsEntryUserId = themeDisplay.getUserId();

if (group.isUser()) {
	microblogsEntryUserId = group.getClassPK();
}

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.NORMAL);

portletURL.setParameter("mvcPath", "/status_update/view.jsp");
%>

<c:if test="<%= MicroblogsPermission.contains(permissionChecker, scopeGroupId, ActionKeys.ADD_ENTRY) && (group.isUser() && !layout.isPublicLayout()) %>">
	<liferay-util:include page="/microblogs/edit_microblogs_entry.jsp" servletContext="<%= application %>" />
</c:if>

<div class="microblogs-container microblogs-status-container">

	<%
	List<MicroblogsEntry> microblogsEntries = null;

	if (microblogsEntryUserId == themeDisplay.getUserId()) {
		microblogsEntries = MicroblogsEntryLocalServiceUtil.getUserMicroblogsEntries(microblogsEntryUserId, 0, 0, 1);
	}
	else {
		microblogsEntries = MicroblogsEntryServiceUtil.getUserMicroblogsEntries(microblogsEntryUserId, 0, 0, 1);
	}

	request.setAttribute(WebKeys.MICROBLOGS_ENTRIES, microblogsEntries);
	request.setAttribute(WebKeys.MICROBLOGS_ENTRIES_URL, portletURL);
	%>

	<liferay-util:include page="/microblogs/view_microblogs_entries.jsp" servletContext="<%= application %>" />
</div>

<aui:script use="aui-base">
	AUI().ready(
		function() {
			Liferay.Microblogs.init(
				{
					microblogsEntriesURL: '<portlet:renderURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>"><portlet:param name="mvcPath" value="/status_update/view.jsp" /></portlet:renderURL>'
				}
			);
		}
	);
</aui:script>