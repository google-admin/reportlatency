-- Copyright 2014 Google Inc. All Rights Reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

CREATE INDEX upload_collected_on ON upload(collected_on);
CREATE INDEX upload_timestamp ON upload(timestamp);
CREATE INDEX upload_location ON upload(location);
CREATE INDEX upload_user_agent ON upload(user_agent);
CREATE INDEX upload_tz ON upload(tz);
CREATE INDEX upload_version ON upload(version);
CREATE INDEX upload_options ON upload(options);
CREATE INDEX navigation_request_name ON navigation_request(name);
CREATE INDEX navigation_request_service ON navigation_request(service);
CREATE INDEX update_request_name ON update_request(name);
CREATE INDEX update_request_service ON update_request(service);
CREATE INDEX navigation_name ON navigation(name);
CREATE INDEX navigation_service ON navigation(service);
CREATE INDEX tag_tag on tag(tag);
CREATE INDEX tag_service on tag(service);
CREATE INDEX location_location ON location(location);
CREATE INDEX location_timestamp ON location(timestamp);
CREATE INDEX location_ip ON location(ip);
