package org.camunda.bpm.engine.rest.dto.task;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @author: drobisch
 */
public class GroupInfoDto {
  private final Set<GroupDto> groups;
  private Map<String, Long> groupCounts;
  private Set<UserDto> groupUsers;

  public GroupInfoDto(Map<String, Long> groupCounts, Set<GroupDto> groups, Set<UserDto> groupUsers) {
    this.groupCounts = groupCounts;
    this.groupUsers = groupUsers;
    this.groups = groups;
  }

  public Map<String, Long> getGroupCounts() {
    return groupCounts;
  }

  public Set<UserDto> getGroupUsers() {
    return groupUsers;
  }

  public Set<GroupDto> getGroups() {
    return groups;
  }
}
