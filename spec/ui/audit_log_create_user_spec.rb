require 'rails_helper'

RSpec.describe "Event Publisher Integration", type: :ui,  perform_enqueued: true do
  describe "Event flow" do
    context 'create user' do
      let(:user) { create(:user, name: "Test",  password: "pass123", password_confirmation: "pass123") }
      it "triggers events on user creation" do
        expect { user }.to change(User, :count).by(1)
      end
    end

    context 'background job' do
      let(:user) { create(:user, name: "Job Test", password: "pass123", password_confirmation: "pass123") }
      let(:params) do
        {
          event_name: 'users.create',
          loggable: {audit_id: user1.id, audit_type: "User"},
          request_id: "RequestString",
          metadata: {name: user1.name},
          created_by_id: user1.id
        }
      end
      it "handles events in background job" do
        ActiveJob::Base.queue_adapter = :test
        
        expect {user}.to have_enqueued_job(AuditLogJob).once
        perform_enqueued_jobs
        expect(AuditLogJob).to have_been_performed
        expect(AuditLog.last.loggable_id).to eq(user.id)
        expect(AuditLog.last.loggable_type).to eq(user.class.name)
        expect(AuditLog.last.metadata.name).to eq(user.name)
      end
    end
  end
end
