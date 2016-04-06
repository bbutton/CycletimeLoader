require 'rspec'
require 'JSON'
require_relative '../lib/vcap_services_parser'

describe 'Retrieves credentials from JSON' do

  it 'should get creds' do
    vcap_json = '{
        "user-provided": [
        {
            "credentials": {
        "DB_HOST": "aatc-demo.il1.rdbs.ctl.io",
        "DB_NAME": "AATC-Demo",
        "DB_PASSWORD": "Dummy",
        "DB_PORT": "49964",
        "DB_USER": "bbutton-aatc"
    },
        "label": "user-provided",
        "name": "aatc_demo_db",
        "syslog_drain_url": "",
        "tags": []
    },
        {
            "credentials": {
        "ORCHESTRATE_API_KEY": "OrcDummyApiKey",
        "ORCHESTRATE_COLLECTION": "Ctl_Lean_Metrics",
        "ORCHESTRATE_ENDPOINT": "https://api.orchestrate.io"
    },
        "label": "user-provided",
        "name": "orchestrate_demo_db",
        "syslog_drain_url": "",
        "tags": []
    },
        {
            "credentials": {
        "TRELLO_DEV_KEY": "TRELLO_DUMMY_DEV_KEY",
        "TRELLO_TOKEN": "TRELLO_DUMMY_TOKEN"
    },
        "label": "user-provided",
        "name": "trello_aatc_service",
        "syslog_drain_url": "",
        "tags": []
    }
    ]
    }'

    parser = VcapServicesParser.new
    variables = parser.parse(vcap_json)

    expect(variables["TRELLO_DEV_KEY"]).to eq("TRELLO_DUMMY_DEV_KEY")
    expect(variables["ORCHESTRATE_API_KEY"]).to eq("OrcDummyApiKey")
    expect(variables["DB_NAME"]).to eq("AATC-Demo")
  end
end