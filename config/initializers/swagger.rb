  GrapeSwaggerRails.options.url      = '/api/v1/swagger_doc.json'
  GrapeSwaggerRails.options.app_name = 'Gallary'
  GrapeSwaggerRails.options.before_action do
    GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
  end
