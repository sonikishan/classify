module ApplicationHelper
  def link_to_add_fields(name, f, association,locals = {})
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s,locals.merge!(f: builder) )
    end
    link_to(name, '#', class: "add_fields label photos", data: {id: id, fields: fields.gsub("\n", "")})
  end
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
end