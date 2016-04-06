require "json"

class VcapServicesParser
  def parse(vcap_json)
    variables = {}
    vcap_data = JSON.parse(vcap_json)

    vcap_data["user-provided"].each do |creds|
      creds["credentials"].each{ |k,v| variables[k] = v}
    end

    variables
  end
end