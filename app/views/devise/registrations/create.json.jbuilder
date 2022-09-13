json.inserted_item render(partial: "devise/registrations/new", formats: :html, locals: {resource: resource})

json.flash_item render(partial: "shared/flashes", formats: :html)
