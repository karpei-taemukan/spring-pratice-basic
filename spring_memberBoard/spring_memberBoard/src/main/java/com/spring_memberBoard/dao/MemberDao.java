package com.spring_memberBoard.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.spring_memberBoard.dto.Board;
import com.spring_memberBoard.dto.Member;

public interface MemberDao {
	
	HashMap<String, String> selectMemberInfo_mapper( @Param("inputId") String inputId);
	
	@Select("SELECT MID, MPW, MNAME,"
		 + " TO_CHAR(MBIRTH, 'YYYY-MM-DD') AS MBIRTH, MEMAIL, MSTATE "
		 + " FROM MEMBERS WHERE MID = #{inputId}")
	Member selectMemberInfo( @Param("inputId") String inputId );
	
	@Select("SELECT * FROM MEMBERS WHERE MID = #{inputId} AND MPW = #{inputPw}")
	Member selectMemberLogin(@Param("inputId") String inputId, @Param("inputPw") String inputPw);

	@Insert("INSERT INTO MEMBERS(MID, MPW, MNAME, MBIRTH, MEMAIL, MSTATE) "
		  + " VALUES( #{mid}, #{mpw}, #{mname}, #{mbirth}, #{memail}, '1' ) ")
	int insertMember(Member member);

	@Update("UPDATE MEMBERS "
		 + " SET MPW = #{mpw}, MNAME = #{mname}, mbirth = #{mbirth}, MEMAIL = #{memail}"
		 + " WHERE MID = #{mid} ")
	int updateMemberInfo(Member member);
	
	@Select("SELECT * FROM BOARDS WHERE BWRITER = #{loginId}")
	ArrayList<Board> selectMemberBCount2( @Param("loginId") String loginId);

	@Select("SELECT COUNT(*) FROM BOARDS WHERE BWRITER = #{loginId}")
	int selectMemberBCount( @Param("loginId") String loginId);
	
	@Select("SELECT COUNT(*) FROM REPLYS WHERE REMID = #{loginId}")
	int selectMemberReCount(@Param("loginId") String loginId);	
	
	
	
	
}










