package model;
// Generated 22/06/2017 19:29:57 by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * TtAgenda generated by hbm2java
 */
public class TtAgenda  implements java.io.Serializable {


     private Integer idtAgenda;
     private TbServico tbServico;
     private String disponibilidadeAgenda;
     private Date horaAgenda;

    public TtAgenda() {
    }

    public TtAgenda(TbServico tbServico, String disponibilidadeAgenda, Date horaAgenda) {
       this.tbServico = tbServico;
       this.disponibilidadeAgenda = disponibilidadeAgenda;
       this.horaAgenda = horaAgenda;
    }
   
    public Integer getIdtAgenda() {
        return this.idtAgenda;
    }
    
    public void setIdtAgenda(Integer idtAgenda) {
        this.idtAgenda = idtAgenda;
    }
    public TbServico getTbServico() {
        return this.tbServico;
    }
    
    public void setTbServico(TbServico tbServico) {
        this.tbServico = tbServico;
    }
    public String getDisponibilidadeAgenda() {
        return this.disponibilidadeAgenda;
    }
    
    public void setDisponibilidadeAgenda(String disponibilidadeAgenda) {
        this.disponibilidadeAgenda = disponibilidadeAgenda;
    }
    public Date getHoraAgenda() {
        return this.horaAgenda;
    }
    
    public void setHoraAgenda(Date horaAgenda) {
        this.horaAgenda = horaAgenda;
    }




}


