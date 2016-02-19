module WaitingHelper
	def wait_for_ajax
		Timeout.timeout(Capybara.default_max_wait_time) do
			until finished_all_ajax_requests? do
				sleep 2
			end
		end
	end

	def wait_for_document
		Timeout.timeout(Capybara.default_max_wait_time) do
			until document_ready? do
				sleep 2
			end
		end
	end

	def wait_for_page
		Timeout.timeout(Capybara.default_max_wait_time) do
			until finished_all_ajax_requests? && document_ready? do
				sleep 2
			end
		end
	end

	def wait_for_location_change(original = current_path)
		Timeout.timeout(Capybara.default_max_wait_time) do
			until location_changed? original do
				sleep 2
			end
		end
	end

	private

	def finished_all_ajax_requests?
		page.evaluate_script('AJS.$.active').zero?
	end

	def document_ready?
		page.evaluate_script('document.readyState === "complete"')
	end

	def location_changed?(path)
		! path.eql?(current_path)
	end
end
