#!/bin/bash
#
# vars
#
# get device id for do
deviceId=$1
#
admin_username='xadmin'
admin_password='pleaseUseVault123!!'
CREDS="$admin_username:$admin_password"
LOG_FILE=/var/log/startup-script.log
# constants
mgmt_port=`tmsh list sys httpd ssl-port | grep ssl-port | sed 's/ssl-port //;s/ //g'`
authUrl="/mgmt/shared/authn/login"
rpmInstallUrl="/mgmt/shared/iapp/package-management-tasks"
rpmFilePath="/var/config/rest/downloads"
local_host="http://localhost:8100"
# do
doUrl="/mgmt/shared/declarative-onboarding"
doCheckUrl="/mgmt/shared/declarative-onboarding/info"
doTaskUrl="/mgmt/shared/declarative-onboarding/task"
# as3
as3Url="/mgmt/shared/appsvcs/declare"
as3CheckUrl="/mgmt/shared/appsvcs/info"
as3TaskUrl="/mgmt/shared/appsvcs/task/"
# ts
tsUrl="/mgmt/shared/telemetry/declare"
tsCheckUrl="/mgmt/shared/telemetry/info"
# cloud failover ext
cfUrl="/mgmt/shared/cloud-failover/declare"
cfCheckUrl="/mgmt/shared/cloud-failover/info"
# fast
fastCheckUrl="/mgmt/shared/fast/info"
# declaration content
cat > /config/do1.json <<EOF
{
    "schemaVersion": "1.9.0",
    "class": "Device",
    "async": true,
    "label": "Basic onboarding",
    "Common": {
        "class": "Tenant",
        "hostname": "f5vm01.example.com",
        "myLicense": {
            "class": "License",
            "licenseType": "regKey",
            "regKey": "HAKBO-WUEAY-QIMPP-ADNIF-MRYWLIJ"
        },
        "dbvars": {
        	"class": "DbVariables",
        	"ui.advisory.enabled": true,
        	"ui.advisory.color": "green",
            "ui.advisory.text": "//UNCLASSIFIED//",
            "ui.system.preferences.advancedselection":  "advanced",
            "ui.system.preferences.recordsperscreen": "100",
            "ui.system.preferences.startscreen": "network_map",
            "ui.users.redirectsuperuserstoauthsummary": "true",
            "dns.cache": "enable",
            "config.allow.rfc3927": "enable",
            "big3d.minimum.tls.version": "TLSV1.2",
            "liveinstall.checksig": "enable"
        },
        "RemoteSyslog": {
            "class": "SyslogRemoteServer",
            "host": "10.99.10.101",
            "localIp": "10.99.1.4",
            "remotePort": 514
          },
        "system":{
            "class": "System",
            "autoCheck": false,
            "autoPhonehome": false,
            "cliInactivityTimeout": 900,
            "consoleInactivityTimeout": 900,
            "guiAuditLog": true,
            "mcpAuditLog": "enable",
            "tmshAuditLog": true
        },
        "httpd": {
            "class": "HTTPD",
            "maxClients": 10,
            "authPamIdleTimeout": 900,
            "sslCiphersuite": ["ECDHE-ECDSA-AES256-GCM-SHA384", "ECDHE-ECDSA-AES256-SHA384", "ECDHE-ECDSA-AES256-SHA","ECDH-ECDSA-AES256-GCM-SHA384", "ECDH-ECDSA-AES256-SHA384", "ECDH-ECDSA-AES256-SHA", "AES256-GCM-SHA384", "AES256-SHA256", "AES256-SHA", "CAMELLIA256-SHA", "ECDHE-RSA-AES128-GCM-SHA256", "ECDHE-ECDSA-AES128-GCM-SHA256", "ECDHE-ECDSA-AES128-SHA256", "ECDHE-RSA-AES128-SHA", "ECDHE-ECDSA-AES128-SHA", "ECDH-ECDSA-AES128-GCM-SHA256", "ECDH-ECDSA-AES128-SHA256", "ECDH-ECDSA-AES128-SHA", "AES128-GCM-SHA256", "AES128-SHA256", "AES128-SHA", "SEED-SHA", "CAMELLIA128-SHA"],
            "sslProtocol": "all -SSLv2 -SSLv3 -TLSv1"
        },
        "sshd": {
            "class": "SSHD",
            "banner": "You are accessing a U.S. Government (USG) Information System (IS) that is provided for USG-authorized use only. By using this IS (which includes any device attached to this IS), you consent to the following conditions: The USG routinely intercepts and monitors communications on this IS for purposes including, but not limited to, penetration testing, COMSEC monitoring, network operations and defense, personnel misconduct (PM), law enforcement (LE), and counterintelligence (CI) investigations. At any time, the USG may inspect and seize data stored on this IS. Communications using, or data stored on, this IS are not private, are subject to routine monitoring, interception, and search, and may be disclosed or used for any USG authorized purpose. This IS includes security measures (e.g., authentication and access controls) to protect USG interests--not for your personal benefit or privacy. Notwithstanding the above, using this IS does not constitute consent to PM, LE or CI investigative searching or monitoring of the content of privileged communications, or work product, related to personal representation or services by attorneys, psychotherapists, or clergy, and their assistants. Such communications and work product are private and confidential. See User Agreement for details.",
            "inactivityTimeout": 900,
            "ciphers": [
                "aes128-ctr",
                "aes192-ctr",
                "aes256-ctr"
            ],
            "loginGraceTime": 60,
            "MACS": [
                "hmac-sha1",
                "hmac-ripemd160"
            ],
            "maxAuthTries": 3,
            "maxStartups": "5",
            "protocol": 2
        },
        "myDns": {
            "class": "DNS",
            "nameServers": [
                "168.63.129.16",
                "2001:4860:4860::8844"
            ],
            "search": [
                "f5.com"
            ]
        },
        "myNtp": {
            "class": "NTP",
            "servers": [
                "time.nist.gov",
                "0.pool.ntp.org",
                "1.pool.ntp.org"
            ],
            "timezone": "UTC"
        },
        "myProvisioning": {
            "class": "Provision",
            "ltm": "nominal",
            "asm": "nominal",
            "afm": "nominal"
        },
        "external": {
            "class": "VLAN",
            "tag": 4094,
            "mtu": 1500,
            "interfaces": [
                {
                    "name": "1.1",
                    "tagged": false
                }
            ]
        },
        "internal": {
            "class": "VLAN",
            "tag": 4093,
            "mtu": 1500,
            "interfaces": [
                {
                    "name": "1.2",
                    "tagged": false
                }
            ]
        },
        "external-self": {
            "class": "SelfIp",
            "address": "10.99.1.4/24",
            "vlan": "external",
            "allowService": "default",
            "trafficGroup": "traffic-group-local-only"
        },
        "internal-self": {
            "class": "SelfIp",
            "address": "10.99.2.4/24",
            "vlan": "internal",
            "allowService": "default",
            "trafficGroup": "traffic-group-local-only"
        },
        "internet": {
            "class": "Route",
            "gw": "10.99.1.1",
            "network": "default",
            "mtu": 1500
        },
        "vdms": {
            "class": "Route",
            "gw": "10.99.2.1",
            "network": "10.99.3.0/24",
            "mtu": 1500
        },
        "vdss": {
            "class": "Route",
            "gw": "10.99.2.1",
            "network": "10.99.0.0/16",
            "mtu": 1500
        },
        "configsync": {
            "class": "ConfigSync",
            "configsyncIp": "/Common/external-self/address"
        },
        "failoverAddress": {
            "class": "FailoverUnicast",
            "address": "/Common/external-self/address"
        },
        "failoverGroup": {
            "class": "DeviceGroup",
            "type": "sync-failover",
            "members": [
                "f5vm01.example.com",
                "f5vm02.example.com"
            ],
            "owner": "/Common/failoverGroup/members/0",
            "autoSync": true,
            "saveOnAutoSync": false,
            "networkFailover": true,
            "fullLoadOnSync": false,
            "asmSync": true
        },
        "trust": {
            "class": "DeviceTrust",
            "localUsername": "xadmin",
            "localPassword": "pleaseUseVault123!!",
            "remoteHost": "10.99.1.5",
            "remoteUsername": "xadmin",
            "remotePassword": "pleaseUseVault123!!"
        }
    }
}
EOF
cat > /config/do2.json <<EOF
{
    "schemaVersion": "1.9.0",
    "class": "Device",
    "async": true,
    "label": "Basic onboarding",
    "Common": {
        "class": "Tenant",
        "hostname": "f5vm02.example.com",
        "myLicense": {
            "class": "License",
            "licenseType": "regKey",
            "regKey": "UMOJH-WZIGW-CZEMI-MSQTF-IPTCECF"
        },
        "dbvars": {
        	"class": "DbVariables",
        	"ui.advisory.enabled": true,
        	"ui.advisory.color": "green",
            "ui.advisory.text": "//UNCLASSIFIED//",
            "ui.system.preferences.advancedselection":  "advanced",
            "ui.system.preferences.recordsperscreen": "100",
            "ui.system.preferences.startscreen": "network_map",
            "ui.users.redirectsuperuserstoauthsummary": "true",
            "dns.cache": "enable",
            "config.allow.rfc3927": "enable",
            "big3d.minimum.tls.version": "TLSV1.2",
            "liveinstall.checksig": "enable"
        },
        "RemoteSyslog": {
            "class": "SyslogRemoteServer",
            "host": "10.99.10.101",
            "localIp": "10.99.1.5",
            "remotePort": 514
          },
        "system":{
            "class": "System",
            "autoCheck": false,
            "autoPhonehome": false,
            "cliInactivityTimeout": 900,
            "consoleInactivityTimeout": 900,
            "guiAuditLog": true,
            "mcpAuditLog": "enable",
            "tmshAuditLog": true
        },
        "httpd": {
            "class": "HTTPD",
            "maxClients": 10,
            "authPamIdleTimeout": 900,
            "sslCiphersuite": ["ECDHE-ECDSA-AES256-GCM-SHA384", "ECDHE-ECDSA-AES256-SHA384", "ECDHE-ECDSA-AES256-SHA","ECDH-ECDSA-AES256-GCM-SHA384", "ECDH-ECDSA-AES256-SHA384", "ECDH-ECDSA-AES256-SHA", "AES256-GCM-SHA384", "AES256-SHA256", "AES256-SHA", "CAMELLIA256-SHA", "ECDHE-RSA-AES128-GCM-SHA256", "ECDHE-ECDSA-AES128-GCM-SHA256", "ECDHE-ECDSA-AES128-SHA256", "ECDHE-RSA-AES128-SHA", "ECDHE-ECDSA-AES128-SHA", "ECDH-ECDSA-AES128-GCM-SHA256", "ECDH-ECDSA-AES128-SHA256", "ECDH-ECDSA-AES128-SHA", "AES128-GCM-SHA256", "AES128-SHA256", "AES128-SHA", "SEED-SHA", "CAMELLIA128-SHA"],
            "sslProtocol": "all -SSLv2 -SSLv3 -TLSv1"
        },
        "sshd": {
            "class": "SSHD",
            "banner": "You are accessing a U.S. Government (USG) Information System (IS) that is provided for USG-authorized use only. By using this IS (which includes any device attached to this IS), you consent to the following conditions: The USG routinely intercepts and monitors communications on this IS for purposes including, but not limited to, penetration testing, COMSEC monitoring, network operations and defense, personnel misconduct (PM), law enforcement (LE), and counterintelligence (CI) investigations. At any time, the USG may inspect and seize data stored on this IS. Communications using, or data stored on, this IS are not private, are subject to routine monitoring, interception, and search, and may be disclosed or used for any USG authorized purpose. This IS includes security measures (e.g., authentication and access controls) to protect USG interests--not for your personal benefit or privacy. Notwithstanding the above, using this IS does not constitute consent to PM, LE or CI investigative searching or monitoring of the content of privileged communications, or work product, related to personal representation or services by attorneys, psychotherapists, or clergy, and their assistants. Such communications and work product are private and confidential. See User Agreement for details.",
            "inactivityTimeout": 900,
            "ciphers": [
                "aes128-ctr",
                "aes192-ctr",
                "aes256-ctr"
            ],
            "loginGraceTime": 60,
            "MACS": [
                "hmac-sha1",
                "hmac-ripemd160"
            ],
            "maxAuthTries": 3,
            "maxStartups": "5",
            "protocol": 2
        },
        "myDns": {
            "class": "DNS",
            "nameServers": [
                "168.63.129.16",
                "2001:4860:4860::8844"
            ],
            "search": [
                "f5.com"
            ]
        },
        "myNtp": {
            "class": "NTP",
            "servers": [
                "time.nist.gov",
                "0.pool.ntp.org",
                "1.pool.ntp.org"
            ],
            "timezone": "UTC"
        },
        "myProvisioning": {
            "class": "Provision",
            "ltm": "nominal",
            "asm": "nominal",
            "afm": "nominal"
        },
        "external": {
            "class": "VLAN",
            "tag": 4094,
            "mtu": 1500,
            "interfaces": [
                {
                    "name": "1.1",
                    "tagged": false
                }
            ]
        },
        "internal": {
            "class": "VLAN",
            "tag": 4093,
            "mtu": 1500,
            "interfaces": [
                {
                    "name": "1.2",
                    "tagged": false
                }
            ]
        },
        "external-self": {
            "class": "SelfIp",
            "address": "10.99.1.5/24",
            "vlan": "external",
            "allowService": "default",
            "trafficGroup": "traffic-group-local-only"
        },
        "internal-self": {
            "class": "SelfIp",
            "address": "10.99.2.5/24",
            "vlan": "internal",
            "allowService": "default",
            "trafficGroup": "traffic-group-local-only"
        },
        "internet": {
            "class": "Route",
            "gw": "10.99.1.1",
            "network": "default",
            "mtu": 1500
        },
        "vdms": {
            "class": "Route",
            "gw": "10.99.2.1",
            "network": "10.99.3.0/24",
            "mtu": 1500
        },
        "vdss": {
            "class": "Route",
            "gw": "10.99.2.1",
            "network": "10.99.0.0/16",
            "mtu": 1500
        },
        "configsync": {
            "class": "ConfigSync",
            "configsyncIp": "/Common/external-self/address"
        },
        "failoverAddress": {
            "class": "FailoverUnicast",
            "address": "/Common/external-self/address"
        },
        "failoverGroup": {
            "class": "DeviceGroup",
            "type": "sync-failover",
            "members": [
                "f5vm01.example.com",
                "f5vm02.example.com"
            ],
            "owner": "/Common/failoverGroup/members/0",
            "autoSync": true,
            "saveOnAutoSync": false,
            "networkFailover": true,
            "fullLoadOnSync": false,
            "asmSync": true
        },
        "trust": {
            "class": "DeviceTrust",
            "localUsername": "xadmin",
            "localPassword": "pleaseUseVault123!!",
            "remoteHost": "10.99.1.4",
            "remoteUsername": "xadmin",
            "remotePassword": "pleaseUseVault123!!"
        }
    }
}
EOF
cat > /config/as3.json <<EOF
{
    "class":"AS3",
    "action":"deploy",
    "persist":true,
    "declaration": { 
        "class": "ADC",
        "schemaVersion": "3.12.0",
        "id": "05faeb52-4c1b-9fa3-73be-ecd770a57df0",
        "label": "scca baseline",
        "remark": "scca baseline 3.12.0",
        "Common": {
            "class": "Tenant",
            "Shared": {
                "class": "Application",
                "template": "shared",
                "fwLogDestinationSyslog": {
                    "class": "Log_Destination",
                    "type": "remote-syslog",
                    "remoteHighSpeedLog": {
                        "use": "fwLogDestinationHsl"
                    },
                    "format": "rfc5424"
                },
                "fwLogDestinationHsl": {
                    "class": "Log_Destination",
                    "type": "remote-high-speed-log",
                    "protocol": "tcp",
                    "pool": {
                        "use": "hsl_pool"
                    }
                },
                "hsl_pool": {
                    "class": "Pool",
                    "members": [
                        {
                            "serverAddresses": [
                                "10.99.10.101"
                            ],
                            "enable": true,
                            "servicePort": 514
                        }
                    ],
                    "monitors": [
                        {
                            "bigip": "/Common/udp"
                        }
                    ]
                },
                "fwLogPublisher": {
                    "class": "Log_Publisher",
                    "destinations": [
                        {
                            "use": "fwLogDestinationSyslog"
                        }
                    ]
                },
                "fwSecurityLogProfile": {
                    "class": "Security_Log_Profile",
                    "network": {
                        "publisher": {
                            "use": "fwLogPublisher"
                        },
                        "storageFormat": {
                            "fields": [
                                "action",
                                "dest-ip",
                                "dest-port",
                                "src-ip",
                                "src-port"
                            ]
                        },
                        "logTranslationFields": true,
                        "logTcpEvents": true,
                        "logRuleMatchRejects": true,
                        "logTcpErrors": true,
                        "logIpErrors": true,
                        "logRuleMatchDrops": true,
                        "logRuleMatchAccepts": true
                    },
                    "application": {
                        "facility": "local3",
                        "storageFilter": {
                            "requestType": "illegal-including-staged-signatures",
                            "responseCodes": [
                                "404",
                                "201"
                            ],
                            "protocols": [
                                "http"
                            ],
                            "httpMethods": [
                                "PATCH",
                                "DELETE"
                            ],
                            "requestContains": {
                                "searchIn": "search-in-request",
                                "value": "The new value"
                            },
                            "loginResults": [
                                "login-result-unknown"
                            ]
                        },
                        "storageFormat": {
                            "fields": [
                                "attack_type",
                                "avr_id",
                                "headers",
                                "is_truncated"
                            ],
                            "delimiter": "."
                        },
                        "localStorage": false,
                        "maxEntryLength": "10k",
                        "protocol": "udp",
                        "remoteStorage": "remote",
                        "reportAnomaliesEnabled": true,
                        "servers": [
                            {
                                "address": "10.99.10.101",
                                "port": "514"
                            }
                        ]
                    },
                    "dosApplication": {
                        "remotePublisher": {
                            "use": "fwLogPublisher"
                        }
                    },
                    "dosNetwork": {
                        "publisher": {
                            "use": "fwLogPublisher"
                        }
                    }
                },
                "example_response": {
                    "class": "iRule",
                    "iRule": "when HTTP_REQUEST {\n    HTTP::respond 200 content {\n        <html>\n        <head>\n        <title>Health Check</title>\n        </head>\n        <body>\n        System is online.\n        </body>\n        </html>\n        }\n}"
                },
                "sccaBaselineWAFPolicy":{
                    "class": "WAF_Policy",
                    "url": "https://raw.githubusercontent.com/f5devcentral/f5-asm-policy-templates/master/owasp_ready_template/owasp-auto-tune-v1.1.xml",
                    "ignoreChanges": false,
                "enforcementMode": "transparent"
                },
                "certificate_default": {
                    "class": "Certificate",
                    "certificate": {
                        "bigip": "/Common/default.crt"
                    },
                    "privateKey": {
                        "bigip": "/Common/default.key"
                    }
                },
                "sccaBaselineClientSSL": {
                    "certificates": [
                        {
                            "certificate": "certificate_default"
                        }
                    ],
                    "ciphers": "HIGH",
                    "class": "TLS_Server"
                },
                "sccaBaselineAFMRuleList":{
                    "class": "Firewall_Rule_List",
                    "rules": [
                        {
                            "action": "accept",
                            "name": "allow_all",
                            "protocol": "any"
                        }
                    ]
                },
                "sccaBaselineAFMPolicy": {
                    "class": "Firewall_Policy",
                    "rules": [
                        {
                            "action": "accept",
                            "loggingEnabled": true,
                            "name": "allow_all",
                            "protocol": "any"
                        },
                        {
                            "action": "accept",
                            "loggingEnabled": true,
                            "name": "deny_all",
                            "protocol": "any"
                        }
                    ]
                    
                },
                "sccaBaselineAFMPolicyHTTP": {
                    "class": "Firewall_Policy",
                    "rules": [
                        {
                            "action": "accept",
                            "loggingEnabled": true,
                            "name": "allow_all",
                            "protocol": "any"
                        },
                        {
                            "action": "accept",
                            "loggingEnabled": true,
                            "name": "deny_all",
                            "protocol": "any"
                        }
                    ]
                    
                }
            }
        },
        "transit": {
            "class": "Tenant",
            "transit": {
                "class": "Application",
                "template": "generic",
                "transit_forward": {
                    "class": "Service_Forwarding",
                    "virtualAddresses": [
                            "0.0.0.0/0"
                    ],
                    "profileL4": {
                        "use": "route_friendly_fastl4"
                    },
                    "virtualPort": 0,
                    "forwardingType": "ip",
                    "layer4": "any",
                    "snat": "auto",
                    "translateServerAddress": false,
                    "translateServerPort": false,
                    "translateClientPort": "preserve-strict"
                },
                "route_friendly_fastl4": {
                    "class": "L4_Profile",
                    "idleTimeout": 300,
                    "looseClose": true,
                    "looseInitialization": true,
                    "resetOnTimeout": false
                },
                "transit_health_irule": {
                    "class": "iRule",
                    "iRule": "when HTTP_REQUEST {\n    HTTP::respond 200 content {\n        <html>\n        <head>\n        <title>Health Check</title>\n        </head>\n        <body>\n        System is online.\n        </body>\n        </html>\n        }\n}"
                },
                "transit_health": {
                    "class": "Service_HTTP",
                    "layer4": "tcp",
                    "iRules": [
                        "transit_health_irule"
                    ],
                    "profileHTTP": {
                        "bigip": "/Common/http"
                    },
                    "profileTCP": {
                        "bigip": "/Common/tcp"
                    },
                    "virtualAddresses": [
                        "10.99.2.11",
                        "10.99.2.12"
                    ],
                    "virtualPort": 34568,
                    "snat": "none"
                }
            }
        },
        "mgmt": {
            "class": "Tenant",
            "admin": {
                "class": "Application",
                "template": "generic",
                "rdp_pool": {
                    "members": [
                        {
                            "addressDiscovery": "static",
                            "servicePort": 3389,
                            "serverAddresses": [
                                "10.99.3.98"
                            ]
                        }
                    ],
                    "monitors": [
                        {
                            "bigip": "/Common/tcp_half_open"
                        }
                    ],
                    "class": "Pool"
                },
                "ssh_pool": {
                    "members": [
                        {
                            "addressDiscovery": "static",
                            "servicePort": 22,
                            "serverAddresses": [
                                "10.99.3.99"
                            ]
                        }
                    ],
                    "monitors": [
                        {
                            "bigip": "/Common/tcp_half_open"
                        }
                    ],
                    "class": "Pool"
                },
                "mgmt_health_irule": {
                    "class": "iRule",
                    "iRule": "when HTTP_REQUEST {\n    HTTP::respond 200 content {\n        <html>\n        <head>\n        <title>Health Check</title>\n        </head>\n        <body>\n        System is online.\n        </body>\n        </html>\n        }\n}"
                },
                "mgmt_http": {
                    "policyFirewallEnforced": {
                        "use": "/Common/Shared/sccaBaselineAFMPolicy"
                    },
                    "layer4": "tcp",
                    "iRules": [
                        "mgmt_health_irule"
                    ],
                    "securityLogProfiles": [
                        {
                            "use": "/Common/Shared/fwSecurityLogProfile"
                        }
                    ],
                    "translateServerAddress": true,
                    "translateServerPort": true,
                    "class": "Service_HTTP",
                    "profileDOS": {
                        "bigip": "/Common/dos"
                    },
                    "profileHTTP": {
                        "bigip": "/Common/http"
                    },
                    "profileTCP": {
                        "bigip": "/Common/tcp"
                    },
                    "virtualAddresses": [
                        "10.99.1.11",
                        "10.99.1.12"
                    ],
                    "virtualPort": 80,
                    "snat": "none"
                },
                "mgmt_rdp": {
                    "policyFirewallEnforced": {
                        "use": "/Common/Shared/sccaBaselineAFMPolicy"
                    },
                    "layer4": "tcp",
                    "pool": "rdp_pool",
                    "securityLogProfiles": [
                        {
                            "use": "/Common/Shared/fwSecurityLogProfile"
                        }
                    ],
                    "translateServerAddress": true,
                    "translateServerPort": true,
                    "class": "Service_TCP",
                    "profileTCP": {
                        "bigip": "/Common/tcp"
                    },
                    "virtualAddresses": [
                        "10.99.1.11",
                        "10.99.1.12"
                    ],
                    "virtualPort": 3389,
                    "snat": "auto"
                },
                "mgmt_ssh": {
                    "policyFirewallEnforced": {
                        "use": "/Common/Shared/sccaBaselineAFMPolicy"
                    },
                    "layer4": "tcp",
                    "pool": "ssh_pool",
                    "securityLogProfiles": [
                        {
                            "use": "/Common/Shared/fwSecurityLogProfile"
                        }
                    ],
                    "translateServerAddress": true,
                    "translateServerPort": true,
                    "class": "Service_TCP",
                    "profileDOS": {
                        "bigip": "/Common/dos"
                    },
                    "profileTCP": {
                        "bigip": "/Common/tcp"
                    },
                    "virtualAddresses": [
                        "10.99.1.11",
                        "10.99.1.12"
                    ],
                    "virtualPort": 22,
                    "snat": "auto"
                }
            }
        },    
        "example": {
            "class": "Tenant",
            "exampleApp": {
                "class": "Application",
                "template": "generic",
                "sccaBaselineExampleIPS": {
                    "policyFirewallEnforced": {
                        "use": "/Common/Shared/sccaBaselineAFMPolicy"
                    },
                    "layer4": "tcp",
                    "securityLogProfiles": [
                        {
                            "use": "/Common/Shared/fwSecurityLogProfile"
                        }
                    ],
                    "translateServerAddress": true,
                    "translateServerPort": false,
                    "class": "Service_TCP",
                    "profileDOS": {
                        "bigip": "/Common/dos"
                    },
                    "profileHTTP": {
                        "bigip": "/Common/http"
                    },
                    "profileTCP": {
                        "bigip": "/Common/tcp"
                    },
                    "virtualAddresses": [
                        "10.99.1.0/24"
                    ],
                    "virtualPort": 0,
                    "snat": "auto",
                    "pool": "sccaBaselineIPSPool"
                    
                },
                "sccaBaselineExampleHTTPS": {
                    "policyFirewallEnforced": {
                        "use": "/Common/Shared/sccaBaselineAFMPolicyHTTP"
                    },
                    "layer4": "tcp",
                    "securityLogProfiles": [
                        {
                            "use": "/Common/Shared/fwSecurityLogProfile"
                        }
                    ],
                    "translateServerAddress": true,
                    "translateServerPort": true,
                    "class": "Service_HTTPS",
                    "profileDOS": {
                        "bigip": "/Common/dos"
                    },
                    "profileHTTP": {
                        "bigip": "/Common/http"
                    },
                    "serverTLS": "/Common/Shared/sccaBaselineClientSSL",
                    "profileTCP": {
                        "bigip": "/Common/tcp"
                    },
                    "virtualAddresses": [
                        "10.99.1.0/24"
                    ],
                    "virtualPort": 443,
                    "snat": "auto",
                    "policyWAF": {
                        "use": "/Common/Shared/sccaBaselineWAFPolicy"
                    },
                    "pool": "sccaBaselineJuiceShop"
                },             
                "sccaBaselineExampleHTTP": {
                    "policyFirewallEnforced": {
                        "use": "/Common/Shared/sccaBaselineAFMPolicyHTTP"
                    },
                    "layer4": "tcp",
                    "securityLogProfiles": [
                        {
                            "use": "/Common/Shared/fwSecurityLogProfile"
                        }
                    ],
                    "translateServerAddress": true,
                    "translateServerPort": true,
                    "class": "Service_HTTP",
                    "profileDOS": {
                        "bigip": "/Common/dos"
                    },
                    "profileHTTP": {
                        "bigip": "/Common/http"
                    },
                    "profileTCP": {
                        "bigip": "/Common/tcp"
                    },
                    "virtualAddresses": [
                        "10.99.1.0/24"
                    ],
                    "virtualPort": 8080,
                    "snat": "auto",
                    "policyWAF": {
                        "use": "/Common/Shared/sccaBaselineWAFPolicy"
                    },
                    "pool": "sccaBaselinePimpMyLogs"
                },
                "sccaBaselineIPSPool": {
                    "members": [
                        {
                            "addressDiscovery": "static",
                            "servicePort": 443,
                            "serverAddresses": [
                                "10.99.10.101"
                            ]
                        }
                    ],
                    "class": "Pool"
                },
                "sccaBaselineJuiceShop": {
                    "monitors": [
                        {
                            "bigip": "/Common/http"
                        }
                    ],
                    "members": [
                        {
                            "addressDiscovery": "static",
                            "servicePort": 3000,
                            "serverAddresses": [
                                "10.99.10.101"
                            ]
                        }
                    ],
                    "class": "Pool"
                },

                "sccaBaselinePimpMyLogs": {
                    "monitors": [
                        {
                            "bigip": "/Common/http"
                        }
                    ],
                    "members": [
                        {
                            "addressDiscovery": "static",
                            "servicePort": 8080,
                            "serverAddresses": [
                                "10.99.10.101"
                            ]
                        }
                    ],
                    "class": "Pool"
                },
                "sccaBaselineDemoAppHttps": {
                    "monitors": [
                        {
                            "bigip": "/Common/https"
                        }
                    ],
                    "members": [
                        {
                            "addressDiscovery": "static",
                            "servicePort":443,
                            "serverAddresses": [
                                "10.99.10.101"
                            ]
                        }
                    ],
                    "class": "Pool"
                },
                "sccaBaselineDemoAppHttp": {
                    "monitors": [
                        {
                            "bigip": "/Common/http"
                        }
                    ],
                    "members": [
                        {
                            "addressDiscovery": "static",
                            "servicePort":80,
                            "serverAddresses": [
                                "10.99.10.101"
                            ]
                        }
                    ],
                    "class": "Pool"
                }
            }
    }
    }
}
EOF

DO_BODY_01="/config/do1.json"
DO_BODY_02="/config/do2.json"
AS3_BODY="/config/as3.json"
DO_URL_POST="/mgmt/shared/declarative-onboarding"
AS3_URL_POST="/mgmt/shared/appsvcs/declare"

# BIG-IPS ONBOARD SCRIPT
if [ ! -e $LOG_FILE ]
then
     touch $LOG_FILE
     exec &>>$LOG_FILE
else
    #if file exists, exit as only want to run once
    exit
fi

exec 1>$LOG_FILE 2>&1

startTime=$(date +%s)
echo "start device ID:$deviceId date: $(date)"
function timer () {
    echo "Time Elapsed: $(( 1 / 3600 ))h $(( (1 / 60) % 60 ))m $(( 1 % 60 ))s"
}
waitMcpd () {
checks=0
while [[ "$checks" -lt 120 ]]; do
    tmsh -a show sys mcp-state field-fmt | grep -q running
   if [ $? == 0 ]; then
       echo "[INFO: mcpd ready]"
       break
   fi
   echo "[WARN: mcpd not ready yet]"
   let checks=checks+1
   sleep 10
done
}
waitActive () {
checks=0
while [[ "$checks" -lt 30 ]]; do
    tmsh -a show sys ready | grep -q no
   if [ $? == 1 ]; then
       echo "[INFO: system ready]"
       break
   fi
   echo "[WARN: system not ready yet count: $checks]"
   tmsh -a show sys ready | grep no
   let checks=checks+1
   sleep 10
done
}
# CHECK TO SEE NETWORK IS READY
count=0
while true
do
  STATUS=$(curl -s -k -I example.com | grep HTTP)
  if [[ $STATUS == *"200"* ]]; then
    echo "[INFO: internet access check passed]"
    break
  elif [ $count -le 6 ]; then
    echo "Status code: $STATUS  Not done yet..."
    count=$[$count+1]
  else
    echo "[WARN: GIVE UP...]"
    break
  fi
  sleep 10
done
# download latest atc tools
toolsList=$(cat -<<EOF
{
  "tools": [
      {
        "name": "f5-declarative-onboarding",
        "version": "latest",
        "url": "https://example.domain.com/do.json"
      },
      {
        "name": "f5-appsvcs-extension",
        "version": "latest",
        "url": "https://example.domain.com/as3.json"
      },
      {
        "name": "f5-telemetry-streaming",
        "version": "latest",
        "url": "https://example.domain.com/ts.json"
      },
      {
        "name": "f5-cloud-failover-extension",
        "version": "latest",
        "url": "https://example.domain.com/cf.json"
      },
      {
        "name": "f5-appsvcs-templates",
        "version": "1.0.0",
        "url": "https://example.domain.com/cf.json"
      }
  ]
}
EOF
)
function getAtc () {
atc=$(echo $toolsList | jq -r .tools[].name)
for tool in $atc
do
    version=$(echo $toolsList | jq -r ".tools[]| select(.name| contains (\"$tool\")).version")
    if [ $version == "latest" ]; then
        path=''
    else
        path='tags/v'
    fi
    echo "downloading $tool, $version"
    if [ $tool == "f5-new-tool" ]; then
        files=$(/usr/bin/curl -sk --interface mgmt https://api.github.com/repos/f5devcentral/$tool/releases/$path$version | jq -r '.assets[] | select(.name | contains (".rpm")) | .browser_download_url')
    else
        files=$(/usr/bin/curl -sk --interface mgmt https://api.github.com/repos/F5Networks/$tool/releases/$path$version | jq -r '.assets[] | select(.name | contains (".rpm")) | .browser_download_url')
    fi
    for file in $files
    do
    echo "download: $file"
    name=$(basename $file )
    # make download dir
    mkdir -p /var/config/rest/downloads
    result=$(/usr/bin/curl -Lsk  $file -o /var/config/rest/downloads/$name)
    done
done
}
echo "----download ATC tools----"
getAtc

# install atc tools
echo "----install ATC tools----"
rpms=$(find $rpmFilePath -name "*.rpm" -type f)
for rpm in $rpms
do
  filename=$(basename $rpm)
  echo "installing $filename"
  if [ -f $rpmFilePath/$filename ]; then
     postBody="{\"operation\":\"INSTALL\",\"packageFilePath\":\"$rpmFilePath/$filename\"}"
     while true
     do
        iappApiStatus=$(curl -s -i -u "$CREDS"  $local_host$rpmInstallUrl | grep HTTP | awk '{print $2}')
        case $iappApiStatus in
            404)
                echo "[WARN: api not ready status: $iappApiStatus]"
                sleep 2
                ;;
            200)
                echo "[INFO: api ready starting install task $filename]"
                install=$(restcurl -s -u "$CREDS" -X POST -d $postBody $rpmInstallUrl | jq -r .id )
                break
                ;;
              *)
                echo "[WARN: api error other status: $iappApiStatus]"
                debug=$(restcurl -u "$CREDS" $rpmInstallUrl)
                #echo "ipp install debug: $debug"
                ;;
        esac
    done
  else
    echo "[WARN: file: $filename not found]"
  fi
  while true
  do
    status=$(restcurl -u "$CREDS" $rpmInstallUrl/$install | jq -r .status)
    case $status in
        FINISHED)
            # finished
            echo " rpm: $filename task: $install status: $status"
            break
            ;;
        STARTED)
            # started
            echo " rpm: $filename task: $install status: $status"
            ;;
        RUNNING)
            # running
            echo " rpm: $filename task: $install status: $status"
            ;;
        FAILED)
            # failed
            error=$(restcurl -u "$CREDS" $rpmInstallUrl/$install | jq .errorMessage)
            echo "failed $filename task: $install error: $error"
            break
            ;;
        *)
            # other
            debug=$(restcurl -u "$CREDS" $rpmInstallUrl/$install | jq . )
            echo "failed $filename task: $install error: $debug"
            ;;
        esac
    sleep 2
    done
done
function getDoStatus() {
    task=$1
    doStatusType=$(restcurl -u "$CREDS" -X GET $doTaskUrl/$task | jq -r type )
    if [ "$doStatusType" == "object" ]; then
        doStatus=$(restcurl -u "$CREDS" -X GET $doTaskUrl/$task | jq -r .result.status)
        echo $doStatus
    elif [ "$doStatusType" == "array" ]; then
        doStatus=$(restcurl -u "$CREDS" -X GET $doTaskUrl/$task | jq -r .[].result.status)
        echo "[INFO: $doStatus]"
    else
        echo "[WARN: unknown type:$doStatusType]"
    fi
}
function checkDO() {
    # Check DO Ready
    count=0
    while [ $count -le 4 ]
    do
    #doStatus=$(curl -i -u "$CREDS" $local_host$doCheckUrl | grep HTTP | awk '{print $2}')
    doStatusType=$(restcurl -u "$CREDS" -X GET $doCheckUrl | jq -r type )
    if [ "$doStatusType" == "object" ]; then
        doStatus=$(restcurl -u "$CREDS" -X GET $doCheckUrl | jq -r .code)
        if [ $? == 1 ]; then
            doStatus=$(restcurl -u "$CREDS" -X GET $doCheckUrl | jq -r .result.code)
        fi
    elif [ "$doStatusType" == "array" ]; then
        doStatus=$(restcurl -u "$CREDS" -X GET $doCheckUrl | jq -r .[].result.code)
    else
        echo "[WARN: unknown type:$doStatusType]"
    fi
    #echo "status $doStatus"
    if [[ $doStatus == "200" ]]; then
        #version=$(restcurl -u "$CREDS" -X GET $doCheckUrl | jq -r .version)
        version=$(restcurl -u "$CREDS" -X GET $doCheckUrl | jq -r .[].version)
        echo "[INFO: Declarative Onboarding $version online]"
        break
    elif [[ $doStatus == "404" ]]; then
        echo "DO Status: $doStatus"
        bigstart restart restnoded
        sleep 30
        bigstart status restnoded | grep running
        status=$?
        echo "restnoded:$status"
    else
        echo "[WARN: DO Status $doStatus]"
        count=$[$count+1]
    fi
    sleep 10
    done
}
function checkAS3() {
    # Check AS3 Ready
    count=0
    while [ $count -le 4 ]
    do
    #as3Status=$(curl -i -u "$CREDS" $local_host$as3CheckUrl | grep HTTP | awk '{print $2}')
    as3Status=$(restcurl -u "$CREDS" -X GET $as3CheckUrl | jq -r .code)
    if  [ "$as3Status" == "null" ] || [ -z "$as3Status" ]; then
        type=$(restcurl -u "$CREDS" -X GET $as3CheckUrl | jq -r type )
        if [ "$type" == "object" ]; then
            as3Status="200"
        fi
    fi
    if [[ $as3Status == "200" ]]; then
        version=$(restcurl -u "$CREDS" -X GET $as3CheckUrl | jq -r .version)
        echo "As3 $version online "
        break
    elif [[ $as3Status == "404" ]]; then
        echo "AS3 Status $as3Status"
        bigstart restart restnoded
        sleep 30
        bigstart status restnoded | grep running
        status=$?
        echo "restnoded:$status"
    else
        echo "AS3 Status $as3Status"
        count=$[$count+1]
    fi
    sleep 10
    done
}
function checkTS() {
    # Check TS Ready
    count=0
    while [ $count -le 4 ]
    do
    tsStatus=$(curl -si -u "$CREDS" http://localhost:8100$tsCheckUrl | grep HTTP | awk '{print $2}')
    if [[ $tsStatus == "200" ]]; then
        version=$(restcurl -u "$CREDS" -X GET $tsCheckUrl | jq -r .version)
        echo "Telemetry Streaming $version online "
        break
    else
        echo "TS Status $tsStatus"
        count=$[$count+1]
    fi
    sleep 10
    done
}
function checkCF() {
    # Check CF Ready
    count=0
    while [ $count -le 4 ]
    do
    cfStatus=$(curl -si -u "$CREDS" $local_host$cfCheckUrl | grep HTTP | awk '{print $2}')
    if [[ $cfStatus == "200" ]]; then
        version=$(restcurl -u "$CREDS" -X GET $cfCheckUrl | jq -r .version)
        echo "Cloud failover $version online "
        break
    else
        echo "Cloud Failover Status $tsStatus"
        count=$[$count+1]
    fi
    sleep 10
    done
}
function checkFAST() {
    # Check FAST Ready
    count=0
    while [ $count -le 4 ]
    do
    fastStatus=$(curl -si -u "$CREDS" $local_host$fastCheckUrl | grep HTTP | awk '{print $2}')
    if [[ "$fastStatus" == "200" ]]; then
        version=$(restcurl -u "$CREDS" -X GET $fastCheckUrl | jq -r .version)
        echo "FAST $version online "
        break
    else
        echo "FAST Status $fastStatus"
        count=$[$count+1]
    fi
    sleep 10
    done
}
### check for apis online
function checkATC() {
    doStatus=$(checkDO)
    as3Status=$(checkAS3)
    tsStatus=$(checkTS)
    cfStatus=$(checkCF)
    fastStatus=$(checkFAST)
    if [[ $doStatus == *"online"* ]] && [[ "$as3Status" = *"online"* ]] && [[ $tsStatus == *"online"* ]] && [[ $cfStatus == *"online"* ]] && [[ $fastStatus == *"online"* ]] ; then
        echo "ATC is ready to accept API calls"
    else
        echo "ATC install failed or ATC is not ready to accept API calls"
    fi
}
echo "----checking ATC install----"
checkATC
function runDO() {
count=0
while [ $count -le 4 ]
    do
    # make task
    task=$(curl -s -u $CREDS -H "Content-Type: Application/json" -H 'Expect:' -X POST $local_host$doUrl -d @/config/$1 | jq -r .id)
    echo "====== starting DO task: $task =========="
    sleep 1
    count=$[$count+1]
    # check task code
    taskCount=0
    while [ $taskCount -le 10 ]
    do
        doCodeType=$(curl -s -u $CREDS -X GET $local_host$doTaskUrl/$task | jq -r type )
        if [[ "$doCodeType" == "object" ]]; then
            code=$(curl -s -u $CREDS -X GET $local_host$doTaskUrl/$task | jq .result.code)
            echo "object: $code"
        elif [ "$doCodeType" == "array" ]; then
            echo "array $code check task, breaking"
            break
        else
            echo "unknown type: $doCodeType"
            debug=$(curl -s -u $CREDS -X GET $local_host$doTaskUrl/$task)
            echo "other debug: $debug"
            code=$(curl -s -u $CREDS -X GET $local_host$doTaskUrl/$task | jq .result.code)
        fi
        sleep 1
        if jq -e . >/dev/null 2>&1 <<<"$code"; then
            echo "Parsed JSON successfully and got something other than false/null count: $taskCount"
            status=$(curl -s -u $CREDS $local_host$doTaskUrl/$task | jq -r .result.status)
            sleep 1
            echo "status: $status code: $code"
            # 200,202,422,400,404,500,422
            echo "DO: $task response:$code status:$status"
            sleep 1
            #FINISHED,STARTED,RUNNING,ROLLING_BACK,FAILED,ERROR,NULL
            case $status in
            FINISHED)
                # finished
                echo " $task status: $status "
                # bigstart start dhclient
                break 2
                ;;
            STARTED)
                # started
                echo " $filename status: $status "
                sleep 30
                ;;
            RUNNING)
                # running
                echo "DO Status: $status task: $task Not done yet...count:$taskCount"
                # wait for active-online-state
                waitMcpd
                if [[ "$taskCount" -le 5 ]]; then
                    sleep 60
                fi
                waitActive
                #sleep 120
                taskCount=$[$taskCount+1]
                ;;
            FAILED)
                # failed
                error=$(curl -s -u $CREDS $local_host$doTaskUrl/$task | jq -r .result.status)
                echo "failed $task, $error"
                #count=$[$count+1]
                break
                ;;
            ERROR)
                # error
                error=$(curl -s -u $CREDS $local_host$doTaskUrl/$task | jq -r .result.status)
                echo "Error $task, $error"
                #count=$[$count+1]
                break
                ;;
            ROLLING_BACK)
                # Rolling back
                echo "Rolling back failed status: $status task: $task"
                break
                ;;
            OK)
                # complete no change
                echo "Complete no change status: $status task: $task"
                break 2
                ;;
            *)
                # other
                echo "other: $status"
                echo "other task: $task count: $taskCount"
                debug=$(curl -s -u $CREDS $local_host$doTaskUrl/$task)
                echo "other debug: $debug"
                case $debug in
                *not*registered*)
                    # restnoded response DO api is unresponsive
                    echo "DO endpoint not avaliable waiting..."
                    sleep 30
                    ;;
                *resterrorresponse*)
                    # restnoded response DO api is unresponsive
                    echo "DO endpoint not avaliable waiting..."
                    sleep 30
                    ;;
                *start-limit*)
                    # dhclient issue hit
                    echo " do dhclient starting issue hit start another task"
                    break
                    ;;
                esac
                sleep 30
                taskCount=$[$taskCount+1]
                ;;
            esac
        else
            echo "Failed to parse JSON, or got false/null"
            echo "DO status code: $code"
            debug=$(curl -s -u $CREDS $local_host$doTaskUrl/$task)
            echo "debug DO code: $debug"
            count=$[$count+1]
        fi
    done
done
}
# mgmt
echo "set management"
echo  -e "create cli transaction;
modify sys global-settings mgmt-dhcp disabled;
submit cli transaction" | tmsh -q
tmsh save /sys config
# get as3 values
externalVip=$(curl -sf --retry 20 -H Metadata:true "http://169.254.169.254/metadata/instance/network/interface?api-version=2017-08-01" | jq -r '.[1].ipv4.ipAddress[1].privateIpAddress')

# end get values

# run DO
echo "----run do----"
count=0
while [ $count -le 4 ]
    do
        doStatus=$(checkDO)
        echo "DO check status: $doStatus"
    if [ $deviceId == 1 ] && [[ "$doStatus" = *"online"* ]]; then
        echo "running do for id:$deviceId"
        bigstart stop dhclient
        runDO do1.json
        if [ "$?" == 0 ]; then
            echo "done with do"
            bigstart start dhclient
            results=$(restcurl -u $CREDS -X GET $doTaskUrl | jq '.[] | .id, .result')
            echo "do results: $results"
            break
        fi
    elif [ $deviceId == 2 ] && [[ "$doStatus" = *"online"* ]]; then
        echo "running do for id:$deviceId"
        bigstart stop dhclient
        runDO do2.json
        if [ "$?" == 0 ]; then
            echo "done with do"
            bigstart start dhclient
            results=$(restcurl -u $CREDS -X GET $doTaskUrl | jq '.[] | .id, .result')
            echo "do results: $results"
            break
        fi
    elif [ $count -le 2 ]; then
        echo "DeviceID: $deviceId Status code: $doStatus DO not ready yet..."
        count=$[$count+1]
        sleep 30
    else
        echo "DO not online status: $doStatus"
        break
    fi
done
function runAS3 () {
    count=0
    while [ $count -le 4 ]
        do
            # wait for do to finish
            waitActive
            # make task
            task=$(curl -s -u $CREDS -H "Content-Type: Application/json" -H 'Expect:' -X POST $local_host$as3Url?async=true -d @/config/as3.json | jq -r .id)
            echo "===== starting as3 task: $task ====="
            sleep 1
            count=$[$count+1]
            # check task code
            taskCount=0
        while [ $taskCount -le 3 ]
        do
            as3CodeType=$(curl -s -u $CREDS -X GET $local_host$as3TaskUrl/$task | jq -r type )
            if [[ "$as3CodeType" == "object" ]]; then
                code=$(curl -s -u $CREDS -X GET $local_host$as3TaskUrl/$task | jq -r .)
                tenants=$(curl -s -u $CREDS -X GET $local_host$as3TaskUrl/$task | jq -r .results[].tenant)
                echo "object: $code"
            elif [ "$as3CodeType" == "array" ]; then
                echo "array $code check task, breaking"
                break
            else
                echo "unknown type:$as3CodeType"
            fi
            sleep 1
            if jq -e . >/dev/null 2>&1 <<<"$code"; then
                echo "Parsed JSON successfully and got something other than false/null"
                status=$(curl -s -u $CREDS $local_host$as3TaskUrl/$task | jq -r  .items[].results[].message)
                case $status in
                *progress)
                    # in progress
                    echo -e "Running: $task status: $status tenants: $tenants count: $taskCount "
                    sleep 120
                    taskCount=$[$taskCount+1]
                    ;;
                *Error*)
                    # error
                    echo -e "Error Task: $task status: $status tenants: $tenants "
                    if [[ "$status" = *"progress"* ]]; then
                        sleep 180
                        break
                    else
                        break
                    fi
                    ;;
                *failed*)
                    # failed
                    echo -e "failed: $task status: $status tenants: $tenants "
                    break
                    ;;
                *success*)
                    # successful!
                    echo -e "success: $task status: $status tenants: $tenants "
                    break 3
                    ;;
                no*change)
                    # finished
                    echo -e "no change: $task status: $status tenants: $tenants "
                    break 4
                    ;;
                *)
                # other
                echo "status: $status"
                debug=$(curl -s -u $CREDS $local_host$as3TaskUrl/$task)
                echo "debug: $debug"
                error=$(curl -s -u $CREDS $local_host$as3TaskUrl/$task | jq -r '.results[].message')
                echo "Other: $task, $error"
                break
                ;;
                esac
            else
                echo "Failed to parse JSON, or got false/null"
                echo "AS3 status code: $code"
                debug=$(curl -s -u $CREDS $local_host$doTaskUrl/$task)
                echo "debug AS3 code: $debug"
                count=$[$count+1]
            fi
        done
    done
}

# modify as3
#sdToken=$(echo "$token" | base64)
sed -i "s/-external-virtual-address-/$externalVip/g" /config/as3.json
#sed -i "s/-sd-sa-token-b64-/$token/g" /config/as3.json
# end modify as3

# metadata route
echo  -e 'create cli transaction;
modify sys db config.allow.rfc3927 value enable;
create sys management-route metadata-route network 169.254.169.254/32 gateway 10.99.0.1;
submit cli transaction' | tmsh -q
tmsh save /sys config
# add management route with metric 0 for the win
route add -net default gw 10.99.0.1 netmask 0.0.0.0 dev mgmt metric 0
#  run as3
count=0
while [ $count -le 4 ]
do
    as3Status=$(checkAS3)
    echo "AS3 check status: $as3Status"
    if [[ "$as3Status" == *"online"* ]]; then
        if [ $deviceId == 1 ]; then
            echo "running as3"
            runAS3
            echo "done with as3"
            results=$(restcurl -u $CREDS $as3TaskUrl | jq '.items[] | .id, .results')
            echo "as3 results: $results"
            break
        else
            echo "Not posting as3 device $deviceid not primary"
            break
        fi
    elif [ $count -le 2 ]; then
        echo "Status code: $as3Status  As3 not ready yet..."
        count=$[$count+1]
    else
        echo "As3 API Status $as3Status"
        break
    fi
done
#
#
# cleanup
## remove declarations
# rm -f /config/do1.json
# rm -f /config/do2.json
# rm -f /config/as3.json
## disable/replace default admin account
# echo  -e "create cli transaction;
# modify /sys db systemauth.primaryadminuser value $admin_username;
# submit cli transaction" | tmsh -q
tmsh save sys config
echo "timestamp end: $(date)"
echo "setup complete $(timer "$(($(date +%s) - $startTime))")"
exit
