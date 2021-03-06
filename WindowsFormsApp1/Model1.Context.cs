//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WindowsFormsApp1
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class databaseEntities : DbContext
    {
        public databaseEntities()
            : base("name=databaseEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<C__RefactorLog> C__RefactorLog { get; set; }
        public virtual DbSet<questions> questions { get; set; }
        public virtual DbSet<questionsAssignedToEachPerson> questionsAssignedToEachPerson { get; set; }
        public virtual DbSet<Sensors> Sensors { get; set; }
        public virtual DbSet<users> users { get; set; }
    
        [DbFunction("databaseEntities", "getAssignedQuestions")]
        public virtual IQueryable<getAssignedQuestions_Result> getAssignedQuestions(Nullable<int> user_id)
        {
            var user_idParameter = user_id.HasValue ?
                new ObjectParameter("user_id", user_id) :
                new ObjectParameter("user_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<getAssignedQuestions_Result>("[databaseEntities].[getAssignedQuestions](@user_id)", user_idParameter);
        }
    
        public virtual int SPaddPerson(string name, string surname, Nullable<System.DateTime> birthdate)
        {
            var nameParameter = name != null ?
                new ObjectParameter("name", name) :
                new ObjectParameter("name", typeof(string));
    
            var surnameParameter = surname != null ?
                new ObjectParameter("surname", surname) :
                new ObjectParameter("surname", typeof(string));
    
            var birthdateParameter = birthdate.HasValue ?
                new ObjectParameter("birthdate", birthdate) :
                new ObjectParameter("birthdate", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("SPaddPerson", nameParameter, surnameParameter, birthdateParameter);
        }
    
        public virtual int SPaskQuestionToPatient(Nullable<int> patientId, Nullable<int> questionId, Nullable<System.DateTime> date)
        {
            var patientIdParameter = patientId.HasValue ?
                new ObjectParameter("patientId", patientId) :
                new ObjectParameter("patientId", typeof(int));
    
            var questionIdParameter = questionId.HasValue ?
                new ObjectParameter("questionId", questionId) :
                new ObjectParameter("questionId", typeof(int));
    
            var dateParameter = date.HasValue ?
                new ObjectParameter("date", date) :
                new ObjectParameter("date", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("SPaskQuestionToPatient", patientIdParameter, questionIdParameter, dateParameter);
        }
    
        public virtual int SPassignSensorToPatient(Nullable<int> patientId, Nullable<int> sensorId)
        {
            var patientIdParameter = patientId.HasValue ?
                new ObjectParameter("patientId", patientId) :
                new ObjectParameter("patientId", typeof(int));
    
            var sensorIdParameter = sensorId.HasValue ?
                new ObjectParameter("sensorId", sensorId) :
                new ObjectParameter("sensorId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("SPassignSensorToPatient", patientIdParameter, sensorIdParameter);
        }
    }
}
