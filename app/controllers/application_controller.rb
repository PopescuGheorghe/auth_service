class ApplicationController < ActionController::API

  # Public: generates the json response
  # obj - object that contains the data sent in a request
  # returns - data in json format
  def build_data_object(obj)
    { success: true, data: obj }.to_json
  end

  # Public: generates error response
  # obj - object that contains the data sent in a request
  # returns json
  def build_error_object(obj)
    obj_errors = []
    obj.errors.messages.each do |k, v|
      obj_errors << "#{k} #{v.join}"
    end
    { success: false, errors: obj_errors }.to_json
  end
end
